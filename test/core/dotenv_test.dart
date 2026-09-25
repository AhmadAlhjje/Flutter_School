import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/config/dotenv.dart';

void main() {
  test('reads KEY=value lines and ignores comments and blank lines', () {
    const content = '''
# Backend API address
API_BASE_URL=http://localhost:4000

  # indented comment
OTHER = value with spaces
''';
    expect(parseDotEnv(content), {'API_BASE_URL': 'http://localhost:4000', 'OTHER': 'value with spaces'});
  });

  test('handles quotes, CRLF line endings and repeated keys', () {
    const content = 'A="https://api.example.com"\r\nB=\'x\'\r\nA=https://second.example.com\r\n';
    expect(parseDotEnv(content), {'A': 'https://second.example.com', 'B': 'x'});
  });

  test('skips malformed lines', () {
    expect(parseDotEnv('=nokey\njust text\nKEY=\n'), {'KEY': ''});
  });
}
