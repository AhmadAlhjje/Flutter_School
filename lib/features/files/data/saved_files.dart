import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../domain/file_entities.dart';

/// What the viewer needs to show a file — from a fresh grant or from the copy saved on the phone.
class FileMeta {
  const FileMeta({
    required this.fileId,
    required this.title,
    required this.kind,
    required this.extension,
    required this.mimeType,
  });

  factory FileMeta.of(FileGrant grant) => FileMeta(
    fileId: grant.fileId,
    title: grant.title,
    kind: grant.kind,
    extension: grant.extension,
    mimeType: grant.mimeType,
  );

  factory FileMeta.fromJson(Map<String, dynamic> json) => FileMeta(
    fileId: json['fileId']! as String,
    title: json['title']! as String,
    kind: FileKind.values.firstWhere((kind) => kind.name == json['kind'], orElse: () => FileKind.other),
    extension: json['extension']! as String,
    mimeType: json['mimeType']! as String,
  );

  final String fileId;
  final String title;
  final FileKind kind;
  final String extension;
  final String mimeType;

  Map<String, Object> toJson() => {
    'fileId': fileId,
    'title': title,
    'kind': kind.name,
    'extension': extension,
    'mimeType': mimeType,
  };
}

class SavedFile {
  const SavedFile(this.meta, this.bytes);

  final FileMeta meta;
  final Uint8List bytes;
}

/// Files the student opened, kept in the app's private storage so each one is downloaded only
/// once (like downloaded videos). One folder per account; a file whose access ended is removed
/// the next time it is opened online.
class SavedFiles {
  SavedFiles({required this.accountId, Future<Directory> Function()? baseDirectory})
    : _baseDirectory = baseDirectory ?? getApplicationSupportDirectory;

  final String accountId;
  final Future<Directory> Function() _baseDirectory;

  Future<Directory> _dir() async => Directory('${(await _baseDirectory()).path}/saved_files/$accountId');

  Future<({File data, File meta})> _paths(String fileId) async {
    final dir = await _dir();
    return (data: File('${dir.path}/$fileId.bin'), meta: File('${dir.path}/$fileId.json'));
  }

  Future<SavedFile?> read(String fileId) async {
    try {
      final paths = await _paths(fileId);
      if (!await paths.meta.exists() || !await paths.data.exists()) return null;
      final meta = FileMeta.fromJson(jsonDecode(await paths.meta.readAsString()) as Map<String, dynamic>);
      return SavedFile(meta, await paths.data.readAsBytes());
    } on Object {
      return null;
    }
  }

  /// The data is written first and the description last: a file only counts as saved when both
  /// are complete.
  Future<void> save(FileMeta meta, List<int> bytes) async {
    try {
      final paths = await _paths(meta.fileId);
      await paths.data.parent.create(recursive: true);
      final partial = File('${paths.data.path}.part');
      await partial.writeAsBytes(bytes, flush: true);
      await partial.rename(paths.data.path);
      await paths.meta.writeAsString(jsonEncode(meta.toJson()), flush: true);
    } on Object {
      // No space: the file is still shown, it will just be downloaded again next time.
    }
  }

  Future<void> remove(String fileId) async {
    try {
      final paths = await _paths(fileId);
      for (final file in [paths.meta, paths.data]) {
        if (await file.exists()) await file.delete();
      }
    } on Object {
      // Already gone.
    }
  }

  Future<Set<String>> ids() async {
    try {
      final dir = await _dir();
      if (!await dir.exists()) return {};
      return {
        await for (final entry in dir.list())
          if (entry.path.endsWith('.json')) entry.uri.pathSegments.last.replaceAll('.json', ''),
      };
    } on Object {
      return {};
    }
  }
}
