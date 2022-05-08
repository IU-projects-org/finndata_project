import 'package:finndata_project/config/themes/themes.dart';
import 'package:finndata_project/models/settings.dart';
import 'package:finndata_project/models/symbol_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../Localization/app_localizations.dart';

SettingsModel appSettings = SettingsModel(theme: false, language: 'English');
MyTheme myTheme = MyTheme();

List<SymbolResultModel> myStocks = [];

const Iterable<Locale> supportedLocales = [
  Locale('en'),
  Locale('ru'),
];

const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
