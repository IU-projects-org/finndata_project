import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  late Map<String, dynamic> _localizedStrings;

  Future<void> load() async {
    final String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map<String, dynamic>((key, value) {
      return MapEntry(key, value);
    });
  }

  dynamic translate(String key) => _localizedStrings[key];

  bool get isEnLocale => locale.languageCode == 'en';
}
