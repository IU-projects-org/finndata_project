import 'package:finndata_project/config/themes/themes.dart';
import 'package:finndata_project/models/settings.dart';
import 'package:finndata_project/models/symbol_result.dart';
import 'package:flutter/cupertino.dart';

SettingsModel appSettings = SettingsModel(theme: false, language: 'English');
MyTheme myTheme = MyTheme();

List<SymbolResultModel> myStocks = [];

/// keys used in integration testing
const ValueKey passwordKey = ValueKey('passwordField'),
    emailKey = ValueKey('emailField'),
    logoutButtonKey = ValueKey('LogoutKey'),
    registerButtonKey = ValueKey('registerButton'),
    loginButtonKey = ValueKey('LoginButton'),
    openSettingsKey = ValueKey('openSettings'),
    openRegistrationScreenButtonKey = ValueKey('openRegistrationScreen'),
    searchButtonKey = ValueKey('searchButton'),
    favouritesButtonKey = ValueKey('favouritesButton'),
    addFavouriteButtonKey = ValueKey('addFavouriteButton'),
    favouriteDescriptionKey = ValueKey('favouriteTitle'),
    yesButtonKey = ValueKey('yesButton');
