import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/core/utils/search.dart';

void main() {
  test('Arabic letter variants, diacritics and tatweel do not matter', () {
    expect(matchesSearch('الاشتقاق', 'الإشتقاق'), isTrue);
    expect(matchesSearch('أحمد', 'احمد'), isTrue);
    expect(matchesSearch('الجلسة الأولى', 'الاولي'), isTrue);
    expect(matchesSearch('الرِّياضيَّات', 'رياضيات'), isTrue);
    expect(matchesSearch('الكيمـــياء', 'كيمياء'), isTrue);
    expect(matchesSearch('مسألة', 'مساله'), isTrue);
  });

  test('case, spaces and empty queries', () {
    expect(matchesSearch('Physics', 'phys'), isTrue);
    expect(matchesSearch('التفاضل والتكامل', '  التفاضل   والتكامل '), isTrue);
    expect(matchesSearch('التفاضل', ''), isTrue);
    expect(matchesSearch('التفاضل', 'الجبر'), isFalse);
  });
}
