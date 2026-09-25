/// Minimal HLS media-playlist handling for offline copies (pure Dart, unit-tested).
class ParsedMediaPlaylist {
  const ParsedMediaPlaylist({required this.keyUri, required this.segmentUris});

  /// URI of the AES-128 key as written in the playlist (relative to the playlist URL).
  final String? keyUri;

  /// Segment URIs in playback order (relative to the playlist URL).
  final List<String> segmentUris;
}

final _keyUriPattern = RegExp(r'URI="([^"]*)"');

ParsedMediaPlaylist parseMediaPlaylist(String content) {
  String? keyUri;
  final segments = <String>[];
  for (final raw in content.split(RegExp(r'\r?\n'))) {
    final line = raw.trim();
    if (line.isEmpty) continue;
    if (line.startsWith('#EXT-X-KEY:')) {
      keyUri ??= _keyUriPattern.firstMatch(line)?.group(1);
    } else if (!line.startsWith('#')) {
      segments.add(line);
    }
  }
  return ParsedMediaPlaylist(keyUri: keyUri, segmentUris: segments);
}

/// Local file name for a segment URI (`seg_00001.ts?token=...` → `seg_00001.ts`).
String segmentFileName(String uri) {
  final path = Uri.parse(uri).path;
  final name = path.substring(path.lastIndexOf('/') + 1);
  if (!RegExp(r'^seg_\d{5,6}\.ts$').hasMatch(name)) {
    throw FormatException('Unexpected segment name: $name');
  }
  return name;
}

/// Rewrites a downloaded playlist for the loopback server: the key URI becomes `key` and every
/// segment points to its local file name. Tokens from the original URLs are dropped.
String buildLocalPlaylist(String content) {
  return content
      .split(RegExp(r'\r?\n'))
      .map((raw) {
        final line = raw.trim();
        if (line.startsWith('#EXT-X-KEY:')) return line.replaceFirst(_keyUriPattern, 'URI="key"');
        if (line.isNotEmpty && !line.startsWith('#')) return segmentFileName(line);
        return raw;
      })
      .join('\n');
}
