import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/security/screen_protection.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/failure_message.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../history/watch_history.dart';
import 'download_button.dart';
import 'player_sources.dart';

/// Lesson video player (spec §36-§38): HLS from a signed, short-lived URL (or the local
/// encrypted copy), a moving watermark, and video hidden while the screen is being captured.
/// Rotating to landscape (or the fullscreen button) switches to fullscreen.
class VideoPlayerPage extends ConsumerStatefulWidget {
  const VideoPlayerPage.online({super.key, required String this.videoId}) : licenseId = null;

  const VideoPlayerPage.offline({super.key, required String this.licenseId}) : videoId = null;

  final String? videoId;
  final String? licenseId;

  @override
  ConsumerState<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends ConsumerState<VideoPlayerPage> {
  /// Where to resume after the stream is re-requested (e.g. the signed URL expired while paused).
  Duration _resumeAt = Duration.zero;

  /// "My videos": where the student stopped last time; updated while watching.
  late final WatchHistory _history = ref.read(watchHistoryProvider.notifier);
  PlayerSource? _watching;
  Duration _duration = Duration.zero;
  Duration _recordedAt = const Duration(days: -1);

  void _remember(PlayerSource source, Duration position, Duration duration) {
    _resumeAt = position;
    _watching = source;
    _duration = duration;
    if ((position - _recordedAt).abs() < const Duration(seconds: 5)) return;
    _recordedAt = position;
    _history.record(videoId: source.videoId, title: source.title, position: position, duration: duration);
  }

  FutureProvider<PlayerSource> get _source =>
      widget.licenseId != null ? offlineSourceProvider(widget.licenseId!) : onlineSourceProvider(widget.videoId!);

  @override
  void dispose() {
    final source = _watching;
    final position = _resumeAt;
    final duration = _duration;
    if (source != null) {
      // After the frame: providers must not change while the widget tree is being finalized.
      unawaited(
        Future<void>.microtask(
          () => _history.record(videoId: source.videoId, title: source.title, position: position, duration: duration),
        ),
      );
    }
    unawaited(SystemChrome.setPreferredOrientations(const []));
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final source = ref.watch(_source);
    final captured = ref.watch(screenCapturedProvider).value ?? false;
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;

    final body = source.when(
      skipLoadingOnRefresh: false,
      loading: () => const _PlayerFrame(child: CircularProgressIndicator(color: Colors.white)),
      error: (error, _) => _SourceError(error: error, onRetry: () => ref.invalidate(_source)),
      data: (data) {
        final continueAt = _resumeAt > Duration.zero ? Duration.zero : _history.resumeAt(data.videoId);
        return _PlayerView(
          key: ObjectKey(data),
          source: data,
          startAt: _resumeAt > Duration.zero ? _resumeAt : continueAt,
          announceContinue: continueAt > Duration.zero,
          hidden: captured,
          fullscreen: landscape,
          onPosition: (position, duration) => _remember(data, position, duration),
          onStreamFailed: () => ref.invalidate(_source),
          below: widget.videoId == null ? null : _VideoDetails(videoId: widget.videoId!, title: data.title),
        );
      },
    );

    return Scaffold(
      backgroundColor: landscape ? Colors.black : null,
      appBar: landscape ? null : AppBar(title: Text(source.value?.title ?? l10n.videos)),
      body: SafeArea(top: !landscape, bottom: !landscape, child: body),
    );
  }
}

class _PlayerView extends StatefulWidget {
  const _PlayerView({
    super.key,
    required this.source,
    required this.startAt,
    this.announceContinue = false,
    required this.hidden,
    required this.fullscreen,
    required this.onPosition,
    required this.onStreamFailed,
    this.below,
  });

  final PlayerSource source;
  final Duration startAt;

  /// [startAt] comes from "My videos": say so, and offer to start over.
  final bool announceContinue;
  final bool hidden;
  final bool fullscreen;
  final void Function(Duration position, Duration duration) onPosition;
  final VoidCallback onStreamFailed;
  final Widget? below;

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {
  late final VideoPlayerController _controller;
  Object? _initError;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      widget.source.uri,
      formatHint: VideoFormat.hls,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    );
    _controller.addListener(_onValue);
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    try {
      await _controller.initialize();
      if (widget.startAt > Duration.zero) await _controller.seekTo(widget.startAt);
      if (!mounted) return;
      setState(() => _ready = true);
      if (widget.announceContinue) _announceContinue();
      if (!widget.hidden) await _controller.play();
    } catch (error) {
      if (mounted) setState(() => _initError = error);
    }
  }

  void _announceContinue() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.continuedFrom(formatDuration(widget.startAt))),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: l10n.startOver, onPressed: () => unawaited(_controller.seekTo(Duration.zero))),
      ),
    );
  }

  void _onValue() {
    final value = _controller.value;
    if (value.isInitialized) widget.onPosition(value.position, value.duration);
    if (value.isPlaying) {
      unawaited(WakelockPlus.enable());
    } else {
      unawaited(WakelockPlus.disable());
    }
  }

  @override
  void didUpdateWidget(covariant _PlayerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hidden && !oldWidget.hidden) unawaited(_controller.pause());
  }

  @override
  void dispose() {
    _controller.removeListener(_onValue);
    unawaited(WakelockPlus.disable());
    unawaited(_controller.dispose());
    super.dispose();
  }

  Future<void> _toggleFullscreen() async {
    if (widget.fullscreen) {
      await SystemChrome.setPreferredOrientations(const [DeviceOrientation.portraitUp]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // Give the rotation back to the device once we are portrait again.
      await Future<void>.delayed(const Duration(milliseconds: 600));
      await SystemChrome.setPreferredOrientations(const []);
    } else {
      await SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget video;
    if (widget.hidden) {
      video = _PlayerFrame(
        child: _Notice(icon: Icons.screen_share_outlined, text: l10n.captureBlocked),
      );
    } else if (_initError != null) {
      video = _PlayerFrame(
        child: _Notice(
          icon: Icons.error_outline_rounded,
          text: l10n.playerError,
          action: OutlinedButton(onPressed: widget.onStreamFailed, child: Text(l10n.retry)),
        ),
      );
    } else if (!_ready) {
      video = const _PlayerFrame(child: CircularProgressIndicator(color: Colors.white));
    } else {
      video = _PlayerSurface(
        controller: _controller,
        fullscreen: widget.fullscreen,
        onToggleFullscreen: _toggleFullscreen,
        onStreamFailed: widget.onStreamFailed,
      );
    }

    if (widget.fullscreen) {
      return ColoredBox(
        color: Colors.black,
        child: Center(child: video),
      );
    }
    return ListView(children: [video, ?widget.below]);
  }
}

/// The video itself with its controls.
class _PlayerSurface extends StatefulWidget {
  const _PlayerSurface({
    required this.controller,
    required this.fullscreen,
    required this.onToggleFullscreen,
    required this.onStreamFailed,
  });

  final VideoPlayerController controller;
  final bool fullscreen;
  final VoidCallback onToggleFullscreen;
  final VoidCallback onStreamFailed;

  @override
  State<_PlayerSurface> createState() => _PlayerSurfaceState();
}

class _PlayerSurfaceState extends State<_PlayerSurface> {
  bool _controlsVisible = true;
  Timer? _hideTimer;
  double? _dragMs;

  VideoPlayerController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _scheduleHide();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying && _dragMs == null) setState(() => _controlsVisible = false);
    });
  }

  void _showControls() {
    setState(() => _controlsVisible = true);
    _scheduleHide();
  }

  Future<void> _togglePlay() async {
    final value = _controller.value;
    if (value.isPlaying) {
      await _controller.pause();
    } else {
      if (value.isCompleted) await _controller.seekTo(Duration.zero);
      await _controller.play();
    }
    _showControls();
  }

  Future<void> _skip(int seconds) async {
    final value = _controller.value;
    final target = value.position + Duration(seconds: seconds);
    await _controller.seekTo(
      target < Duration.zero ? Duration.zero : (target > value.duration ? value.duration : target),
    );
    _showControls();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        final aspect = value.aspectRatio > 0 ? value.aspectRatio : 16 / 9;
        final showControls = _controlsVisible || !value.isPlaying || value.hasError;
        return AspectRatio(
          aspectRatio: widget.fullscreen ? max(aspect, MediaQuery.sizeOf(context).aspectRatio) : aspect,
          child: ColoredBox(
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: AspectRatio(aspectRatio: aspect, child: VideoPlayer(_controller)),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () =>
                      showControls && value.isPlaying ? setState(() => _controlsVisible = false) : _showControls(),
                  onDoubleTapDown: (details) {
                    final box = context.size;
                    if (box == null) return;
                    final isRtl = Directionality.of(context) == TextDirection.rtl;
                    final startSide = details.localPosition.dx < box.width / 2;
                    unawaited(_skip(startSide != isRtl ? -10 : 10));
                  },
                ),
                if (value.isBuffering && !value.hasError)
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
                if (value.hasError)
                  Center(
                    child: _Notice(
                      icon: Icons.error_outline_rounded,
                      text: l10n.playerError,
                      action: OutlinedButton(onPressed: widget.onStreamFailed, child: Text(l10n.retry)),
                    ),
                  )
                else ...[
                  // The shading never takes touches, so taps on empty areas reach the detector.
                  IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: showControls ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00000000), Color(0x00000000), Color(0xAA000000)],
                          ),
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: !showControls,
                    child: AnimatedOpacity(
                      opacity: showControls ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: _controls(context, value),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _controls(BuildContext context, VideoPlayerValue value) {
    final l10n = AppLocalizations.of(context);
    final durationMs = value.duration.inMilliseconds.toDouble();
    final positionMs = (_dragMs ?? value.position.inMilliseconds.toDouble()).clamp(0, max(durationMs, 1)).toDouble();
    return Stack(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: [
              _RoundButton(
                icon: Icons.replay_10_rounded,
                size: 30,
                tooltip: l10n.rewind10,
                onPressed: () => _skip(-10),
              ),
              const SizedBox(width: 24),
              _RoundButton(
                icon: value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 44,
                tooltip: value.isPlaying ? l10n.pause : l10n.play,
                onPressed: _togglePlay,
              ),
              const SizedBox(width: 24),
              _RoundButton(
                icon: Icons.forward_10_rounded,
                size: 30,
                tooltip: l10n.forward10,
                onPressed: () => _skip(10),
              ),
            ],
          ),
        ),
        Positioned(
          left: 8,
          right: 8,
          bottom: 0,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Text(
                  formatDuration(Duration(milliseconds: positionMs.round())),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                      inactiveTrackColor: Colors.white24,
                      activeTrackColor: Colors.white,
                      thumbColor: Colors.white,
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    ),
                    child: Slider(
                      value: positionMs,
                      max: max(durationMs, 1),
                      onChangeStart: (_) => _hideTimer?.cancel(),
                      onChanged: (ms) => setState(() => _dragMs = ms),
                      onChangeEnd: (ms) async {
                        await _controller.seekTo(Duration(milliseconds: ms.round()));
                        if (mounted) setState(() => _dragMs = null);
                        _scheduleHide();
                      },
                    ),
                  ),
                ),
                Text(formatDuration(value.duration), style: const TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 4),
                SpeedButton(
                  speed: value.playbackSpeed,
                  onOpened: () => _hideTimer?.cancel(),
                  onClosed: _scheduleHide,
                  onSelected: (speed) async {
                    await _controller.setPlaybackSpeed(speed);
                    _scheduleHide();
                  },
                ),
                IconButton(
                  tooltip: widget.fullscreen ? l10n.exitFullscreen : l10n.fullscreen,
                  color: Colors.white,
                  icon: Icon(widget.fullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded),
                  onPressed: widget.onToggleFullscreen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Playback speeds offered to students.
const playbackSpeeds = [0.5, 1.0, 1.5, 2.0];

/// "1.5x" — no trailing ".0".
String speedLabel(double speed) => '${speed == speed.roundToDouble() ? speed.toInt() : speed}x';

/// The current speed ("1x"); tapping it offers 0.5x, 1x, 1.5x and 2x.
class SpeedButton extends StatelessWidget {
  const SpeedButton({super.key, required this.speed, required this.onSelected, this.onOpened, this.onClosed});

  final double speed;
  final ValueChanged<double> onSelected;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      tooltip: AppLocalizations.of(context).playbackSpeed,
      initialValue: speed,
      onOpened: onOpened,
      onCanceled: onClosed,
      onSelected: onSelected,
      position: PopupMenuPosition.over,
      itemBuilder: (context) => [
        for (final option in playbackSpeeds)
          PopupMenuItem<double>(
            value: option,
            child: Row(
              children: [
                SizedBox(width: 24, child: option == speed ? const Icon(Icons.check_rounded, size: 18) : null),
                Text(speedLabel(option), textDirection: TextDirection.ltr),
              ],
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          speedLabel(speed),
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.size, required this.onPressed, this.tooltip});

  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      shape: const CircleBorder(),
      child: IconButton(tooltip: tooltip, iconSize: size, color: Colors.white, icon: Icon(icon), onPressed: onPressed),
    );
  }
}

class _PlayerFrame extends StatelessWidget {
  const _PlayerFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: Colors.black,
        child: Center(child: child),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.text, this.action});

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 36),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          if (action != null) ...[
            const SizedBox(height: 12),
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                ),
              ),
              child: action!,
            ),
          ],
        ],
      ),
    );
  }
}

class _SourceError extends StatelessWidget {
  const _SourceError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final failure = error is AppFailure ? error as AppFailure : null;
    if (failure?.code == 'OFFLINE_EXPIRED' || failure?.code == 'OFFLINE_KEY_MISSING') {
      return _MessageBody(icon: Icons.history_toggle_off_rounded, text: l10n.downloadExpired);
    }
    if (failure?.kind == FailureKind.accessDenied) return const LockedContentView();
    return _MessageBody(
      icon: Icons.error_outline_rounded,
      text: failureMessage(l10n, error),
      action: OutlinedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh_rounded), label: Text(l10n.retry)),
    );
  }
}

class _MessageBody extends StatelessWidget {
  const _MessageBody({required this.icon, required this.text, this.action});

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(height: 12),
            Text(text, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}

/// Title and offline-download action under the video (streaming mode only).
class _VideoDetails extends StatelessWidget {
  const _VideoDetails({required this.videoId, required this.title});

  final String videoId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          Semantics(
            label: l10n.downloadOffline,
            child: DownloadButton(videoId: videoId, title: title),
          ),
        ],
      ),
    );
  }
}
