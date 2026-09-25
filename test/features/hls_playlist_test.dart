import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/features/videos/data/offline/hls_playlist.dart';

const _served = '''
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:4
#EXT-X-MEDIA-SEQUENCE:0
#EXT-X-PLAYLIST-TYPE:VOD
#EXT-X-KEY:METHOD=AES-128,URI="key?token=abc.def",IV=0x00000000000000000000000000000001
#EXTINF:4.000000,
seg_00000.ts?token=abc.def
#EXTINF:4.000000,
seg_00001.ts?token=abc.def
#EXTINF:1.500000,
seg_00002.ts?token=abc.def
#EXT-X-ENDLIST
''';

void main() {
  test('parses the key and the segments in order', () {
    final parsed = parseMediaPlaylist(_served);
    expect(parsed.keyUri, 'key?token=abc.def');
    expect(parsed.segmentUris, [
      'seg_00000.ts?token=abc.def',
      'seg_00001.ts?token=abc.def',
      'seg_00002.ts?token=abc.def',
    ]);
  });

  test('handles CRLF line endings', () {
    final parsed = parseMediaPlaylist(_served.replaceAll('\n', '\r\n'));
    expect(parsed.segmentUris, hasLength(3));
  });

  test('the local playlist drops every token and points to local files', () {
    final local = buildLocalPlaylist(_served);
    expect(local, isNot(contains('token')));
    expect(local, contains('#EXT-X-KEY:METHOD=AES-128,URI="key",IV=0x00000000000000000000000000000001'));
    expect(local, contains('\nseg_00000.ts\n'));
    expect(local, contains('\nseg_00002.ts\n'));
    expect(local, contains('#EXT-X-ENDLIST'));
  });

  test('segment names are strictly validated (no path traversal)', () {
    expect(segmentFileName('https://api.test/media/videos/v1/360p/seg_00007.ts?token=x'), 'seg_00007.ts');
    expect(() => segmentFileName('../../secrets.ts'), throwsFormatException);
    expect(() => segmentFileName('seg_00001.ts/../../x'), throwsFormatException);
    expect(() => segmentFileName('index.m3u8'), throwsFormatException);
  });
}
