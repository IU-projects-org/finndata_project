import 'package:flutter/material.dart';

import '../constants/constants.dart';

ThemeData standardTheme() => ThemeData(
    brightness: Brightness.light,
    cardColor: standardCardColor,
    primaryColor: whiteColor,
    backgroundColor: standardBackgroundColor,
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
          fontSize: 50, color: blackColor, fontWeight: FontWeight.bold),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: blackColor),
    iconTheme: IconThemeData(color: blackColor));

ThemeData blackTheme() => ThemeData(
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
