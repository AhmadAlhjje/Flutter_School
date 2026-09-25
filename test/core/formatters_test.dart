import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/utils/formatters.dart';

void main() {
  test('formatDuration', () {
    expect(formatDuration(const Duration(seconds: 5)), '0:05');
    expect(formatDuration(const Duration(seconds: 125)), '2:05');
    expect(formatDuration(const Duration(seconds: 3725)), '1:02:05');
  });

  test('formatBytes', () {
    expect(formatBytes(512, locale: 'en'), '512 B');
    expect(formatBytes(1536, locale: 'en'), '1.5 KB');
    expect(formatBytes(250 * 1024 * 1024, locale: 'en'), '250 MB');
    expect(formatBytes(1024 * 1024, locale: 'ar'), '1.0 م.ب');
  });

  test('normalizePhone converts Arabic-Indic digits and strips separators', () {
    expect(normalizePhone('٠٩٣٣ ٣٣٣ ٣٣٣'), '0933333333');
    expect(normalizePhone('۰۹۳۳-۳۳۳-۳۳۳'), '0933333333');
    expect(normalizePhone('00963 933 333 333'), '+963933333333');
    expect(normalizePhone('(0933) 333.333'), '0933333333');
  });

  test('isValidPhone', () {
    expect(isValidPhone('0933333333'), isTrue);
    expect(isValidPhone('+963933333333'), isTrue);
    expect(isValidPhone('٠٩٣٣٣٣٣٣٣٣'), isTrue);
    expect(isValidPhone('12345'), isFalse);
    expect(isValidPhone('09333abc33'), isFalse);
  });

  test('isStrongPassword mirrors the backend policy', () {
    expect(isStrongPassword('Student123'), isTrue);
    expect(isStrongPassword('كلمةسر123'), isTrue);
    expect(isStrongPassword('short1'), isFalse);
    expect(isStrongPassword('onlyletters'), isFalse);
    expect(isStrongPassword('1234567890'), isFalse);
  });
}
