import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/failure_message.dart';
import '../../../shared/widgets/locked_content.dart';
import '../../../shared/widgets/state_views.dart';
import '../../catalog_repositories.dart';
import '../domain/file_entities.dart';
import 'file_tile.dart';

sealed class FileLoad {
  const FileLoad();
}

class FileLoading extends FileLoad {
  const FileLoading(this.progress);

  /// 0..1, or null before the size is known.
  final double? progress;
}

class FileLoaded extends FileLoad {
  const FileLoaded(this.grant, this.bytes);

  final FileGrant grant;
  final Uint8List bytes;
}

/// Access check → short-lived URL → download into memory, with progress.
final fileLoadProvider = StreamProvider.autoDispose.family<FileLoad, String>((ref, fileId) {
  final repository = ref.watch(filesRepositoryProvider);
  final events = StreamController<FileLoad>();
  var lastPercent = -1;

  void emit(FileLoad event) {
    if (!events.isClosed) events.add(event);
  }

  Future<void> run() async {
    try {
      emit(const FileLoading(null));
      final grant = await repository.requestAccess(fileId);
      final bytes = await repository.download(
        grant,
        onProgress: (transfer) {
          final progress = transfer.fraction;
          final percent = (progress * 100).floor();
          if (percent == lastPercent) return;
          lastPercent = percent;
          emit(FileLoading(progress));
        },
      );
      emit(FileLoaded(grant, Uint8List.fromList(bytes)));
    } catch (error, stack) {
      if (!events.isClosed) events.addError(error, stack);
    } finally {
      await events.close();
    }
  }

  unawaited(run());
  ref.onDispose(events.close);
  return events.stream;
});

/// In-app viewer for educational files (spec §40): PDFs and images render inside the app;
/// other types are handed to an installed app from the app-private cache.
class FileViewerPage extends ConsumerWidget {
  const FileViewerPage({super.key, required this.fileId, this.title});

  final String fileId;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final load = ref.watch(fileLoadProvider(fileId));
    final loadedTitle = switch (load.value) {
      FileLoaded(:final grant) => grant.title,
      _ => null,
    };
    return Scaffold(
      appBar: AppBar(title: Text(loadedTitle ?? title ?? l10n.files)),
      body: AsyncValueView<FileLoad>(
        value: load,
        onRetry: () => ref.invalidate(fileLoadProvider(fileId)),
        onLocked: () => LockedContentView(title: title),
        data: (state) => switch (state) {
          FileLoading(:final progress) => _Progress(progress: progress),
          FileLoaded(:final grant, :final bytes) => switch (grant.kind) {
            FileKind.pdf => PdfViewer.data(
              bytes,
              sourceName: 'file-${grant.fileId}.pdf',
              params: const PdfViewerParams(backgroundColor: AppColors.muted),
            ),
            FileKind.image => InteractiveViewer(
              maxScale: 6,
              child: Center(
                child: Image.memory(bytes, errorBuilder: (_, _, _) => EmptyView(message: l10n.fileTooLargeToPreview)),
              ),
            ),
            _ => _ExternalFile(grant: grant, bytes: bytes),
          },
        },
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = progress == null ? null : (progress! * 100).floor();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 220, child: LinearProgressIndicator(value: progress)),
            const SizedBox(height: 12),
            Text(percent == null ? l10n.downloadingFile : l10n.downloadingPercent(percent)),
          ],
        ),
      ),
    );
  }
}

/// Word, PowerPoint, Excel, archives...: written to the app's private cache and opened with
/// an installed viewer. Only the most recent such file is kept in the cache.
class _ExternalFile extends StatefulWidget {
  const _ExternalFile({required this.grant, required this.bytes});

  final FileGrant grant;
  final Uint8List bytes;

  @override
  State<_ExternalFile> createState() => _ExternalFileState();
}

class _ExternalFileState extends State<_ExternalFile> {
  bool _opening = false;
  String? _error;

  Future<void> _open() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _opening = true;
      _error = null;
    });
    try {
      final cache = Directory('${(await getTemporaryDirectory()).path}/opened_files');
      if (await cache.exists()) await cache.delete(recursive: true);
      await cache.create(recursive: true);
      final safeName = widget.grant.title.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final file = File('${cache.path}/$safeName.${widget.grant.extension}');
      await file.writeAsBytes(widget.bytes, flush: true);
      final result = await OpenFilex.open(file.path, type: widget.grant.mimeType);
      if (result.type == ResultType.noAppToOpen) {
        if (mounted) setState(() => _error = l10n.noAppToOpenFile);
      } else if (result.type != ResultType.done) {
        if (mounted) setState(() => _error = l10n.errorGeneric);
      }
    } catch (error) {
      if (mounted) setState(() => _error = failureMessage(l10n, error));
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = fileKindColor(widget.grant.kind);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(fileKindIcon(widget.grant.kind), size: 38, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              widget.grant.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(widget.grant.extension.toUpperCase(), style: const TextStyle(color: AppColors.secondary)),
            const SizedBox(height: 12),
            Text(
              l10n.fileOpensExternally,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.secondary),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.danger),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _opening ? null : _open,
              icon: const Icon(Icons.open_in_new_rounded),
              label: Text(l10n.openFile),
            ),
          ],
        ),
      ),
    );
  }
}
