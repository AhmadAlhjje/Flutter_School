import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/core/settings/locale_controller.dart';

void main() {
  test('first release: Arabic only, even on a phone that chose English before', () async {
    expect(englishEnabled, isFalse);
    SharedPreferences.setMockInitialValues({'app.locale': 'en'});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)]);
    addTearDown(container.dispose);
    expect(container.read(localeControllerProvider), const Locale('ar'));
  });
}
