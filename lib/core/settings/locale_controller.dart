import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provided in `main()` after `SharedPreferences.getInstance()` (overridden in tests).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

const supportedLocales = [Locale('ar'), Locale('en')];

/// First release: Arabic only — the language choice is hidden and a saved English choice is
/// ignored. The English translations stay; set this to true to offer English again.
const englishEnabled = false;

/// UI language (Arabic by default, English when enabled and chosen). Persisted across launches.
class LocaleController extends Notifier<Locale> {
  static const _key = 'app.locale';

  @override
  Locale build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(_key);
    return englishEnabled && saved == 'en' ? const Locale('en') : const Locale('ar');
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref.read(sharedPreferencesProvider).setString(_key, locale.languageCode);
  }
}

final localeControllerProvider = NotifierProvider<LocaleController, Locale>(LocaleController.new);
