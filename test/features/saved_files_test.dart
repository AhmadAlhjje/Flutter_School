import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/errors/app_failure.dart';
import 'package:student_app/core/network/network_providers.dart';
import 'package:student_app/core/network/transfer.dart';
import 'package:student_app/features/catalog_repositories.dart';
import 'package:student_app/features/files/data/saved_files.dart';
import 'package:student_app/features/files/domain/file_entities.dart';
import 'package:student_app/features/files/files_providers.dart';
import 'package:student_app/features/files/presentation/file_viewer_page.dart';

/// The server side of files: access check + download, both counted; access can be switched off.
class _Files implements FilesRepository {
  int accessChecks = 0;
  int downloads = 0;
  AppFailure? accessFailure;
  String title = 'أوراق العمل';

  @override
  Future<FileGrant> requestAccess(String fileId) async {
    accessChecks++;
    if (accessFailure != null) throw accessFailure!;
    return FileGrant(
      fileId: fileId,
      title: title,
      kind: FileKind.pdf,
      extension: 'pdf',
      mimeType: 'application/pdf',
      url: 'http://api.test/media/$fileId?token=t',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    );
  }

  @override
  Future<List<int>> download(FileGrant grant, {void Function(TransferProgress progress)? onProgress}) async {
    downloads++;
    onProgress?.call(const TransferProgress(1, 4));
    return [37, 80, 68, 70];
  }
}

void main() {
  late Directory dir;
  late _Files files;
  late SavedFiles saved;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('saved-files');
    files = _Files();
    saved = SavedFiles(accountId: 'student-1', baseDirectory: () async => dir);
  });
  tearDown(() => dir.delete(recursive: true));

  /// Opens the file viewer's loader once (as opening the file screen does) and waits for the end.
  Future<FileLoaded> open(String fileId, {bool offline = false}) async {
    final container = ProviderContainer(
      overrides: [filesRepositoryProvider.overrideWithValue(files), savedFilesProvider.overrideWithValue(saved)],
    );
    container.read(offlineModeProvider).active = offline;
    final done = Completer<FileLoaded>();
    final subscription = container.listen(fileLoadProvider(fileId), (_, next) {
      if (done.isCompleted) return;
      if (next.value case final FileLoaded loaded) done.complete(loaded);
      if (next.hasError) done.completeError(next.error!);
    });
    try {
      return await done.future;
    } finally {
      subscription.close();
      // Let the save that follows the first display finish before the container goes.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      container.dispose();
    }
  }

  test('a file is downloaded the first time only; after that it opens from the phone', () async {
    final first = await open('f1');
    final second = await open('f1');

    expect(files.downloads, 1);
    expect(second.bytes, first.bytes);
    expect(second.file.title, 'أوراق العمل');
    expect(await saved.ids(), {'f1'});
  });

  test('without network a saved file still opens; a file never opened cannot', () async {
    await open('f1');
    files.accessFailure = const AppFailure(FailureKind.network);

    expect((await open('f1')).bytes, [37, 80, 68, 70]);
    await expectLater(
      open('f2'),
      throwsA(isA<AppFailure>().having((failure) => failure.kind, 'kind', FailureKind.network)),
    );
    expect(files.downloads, 1);
  });

  test('offline mode opens the saved copy without asking the server', () async {
    await open('f1');
    final checks = files.accessChecks;

    await open('f1', offline: true);
    expect(files.accessChecks, checks);
  });

  test('online, the access check still runs: a file the student lost is removed from the phone', () async {
    await open('f1');
    files.accessFailure = const AppFailure(FailureKind.accessDenied, code: 'ACCESS_DENIED');

    await expectLater(open('f1'), throwsA(isA<AppFailure>()));
    expect(await saved.ids(), isEmpty);
    expect(await saved.read('f1'), isNull);
  });

  test('a renamed file shows its new title while the saved content is reused', () async {
    await open('f1');
    files.title = 'أوراق العمل (محدّثة)';

    expect((await open('f1')).file.title, 'أوراق العمل (محدّثة)');
    expect(files.downloads, 1);
  });

  test('each account has its own saved files', () async {
    await saved.save(
      const FileMeta(fileId: 'f1', title: 'ملف', kind: FileKind.pdf, extension: 'pdf', mimeType: 'application/pdf'),
      [1, 2, 3],
    );
    final other = SavedFiles(accountId: 'student-2', baseDirectory: () async => dir);

    expect(await saved.ids(), {'f1'});
    expect(await other.ids(), isEmpty);
    expect(await other.read('f1'), isNull);
  });
}
