import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(String languageCode) {
    if (!['en', 'fr', 'tn'].contains(languageCode)) return;
    _locale = Locale(languageCode);
    notifyListeners();
  }

  String translate(String key) {
    return AppTranslations.data[_locale.languageCode]?[key] ?? key;
  }
}
