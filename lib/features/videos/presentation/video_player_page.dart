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

  FutureProvider<PlayerSource> get _source =>
      widget.licenseId != null ? offlineSourceProvider(widget.licenseId!) : onlineSourceProvider(widget.videoId!);

  @override
  void dispose() {
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
      data: (data) => _PlayerView(
        key: ObjectKey(data),
        source: data,
        startAt: _resumeAt,
        hidden: captured,
        fullscreen: landscape,
        onPosition: (position) => _resumeAt = position,
        onStreamFailed: () => ref.invalidate(_source),
        below: widget.videoId == null ? null : _VideoDetails(videoId: widget.videoId!, title: data.title),
      ),
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
    required this.hidden,
    required this.fullscreen,
    required this.onPosition,
    required this.onStreamFailed,
    this.below,
  });

  final PlayerSource source;
  final Duration startAt;
  final bool hidden;
  final bool fullscreen;
  final ValueChanged<Duration> onPosition;
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
      if (!widget.hidden) await _controller.play();
    } catch (error) {
      if (mounted) setState(() => _initError = error);
    }
  }

  void _onValue() {
    final value = _controller.value;
    if (value.isInitialized) widget.onPosition(value.position);
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
        watermark: widget.source.watermark,
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

/// The video itself with watermark and controls.
class _PlayerSurface extends StatefulWidget {
  const _PlayerSurface({
    required this.controller,
    required this.watermark,
    required this.fullscreen,
    required this.onToggleFullscreen,
    required this.onStreamFailed,
  });

  final VideoPlayerController controller;
  final String? watermark;
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
                if (widget.watermark != null) MovingWatermark(text: widget.watermark!),
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

/// Student name + phone drifting across the video so a camera recording identifies the
/// source (spec §38). Purely visual; it never intercepts touches.
class MovingWatermark extends StatefulWidget {
  const MovingWatermark({super.key, required this.text});

  final String text;

  @override
  State<MovingWatermark> createState() => _MovingWatermarkState();
}

class _MovingWatermarkState extends State<MovingWatermark> {
  final _random = Random();
  Alignment _alignment = const Alignment(-0.6, -0.6);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() => _alignment = Alignment(_random.nextDouble() * 1.6 - 0.8, _random.nextDouble() * 1.6 - 0.8));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedAlign(
        alignment: _alignment,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
        child: Text(
          widget.text,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.38),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            shadows: const [Shadow(color: Color(0x66000000), blurRadius: 2)],
          ),
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
