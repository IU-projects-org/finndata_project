import 'package:finndata_project/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

// ignore: prefer_mixin
class MyTheme with ChangeNotifier {
  ThemeData currentTheme() {
    return appSettings.theme ? standardTheme() : darkTheme();
  }

  void switchTheme() {
    appSettings.theme = !appSettings.theme;
    notifyListeners();
  }

  ThemeData standardTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      brightness: Brightness.light,
      cardColor: standardCardColor,
      primaryColor: whiteColor,
      backgroundColor: standardBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black38),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: TextTheme(
        headline3: TextStyle(
            fontSize: 50, color: blackColor, fontWeight: FontWeight.bold),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: blackColor),
      iconTheme: IconThemeData(color: blackColor));
  ThemeData darkTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      brightness: Brightness.dark,
      cardColor: blackCardColor,
      primaryColor: whiteColor,
      backgroundColor: blackBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black38),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black45),
        ),
      ),
      textTheme: TextTheme(
        headline3: TextStyle(
            fontSize: 50, color: whiteColor, fontWeight: FontWeight.bold),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: whiteColor),
      iconTheme: IconThemeData(color: whiteColor));
}
