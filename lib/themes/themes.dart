import 'package:flutter/material.dart';

import '../constants/constants.dart';

ThemeData standardTheme() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
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
    textTheme: const TextTheme(
      headline3: TextStyle(
          fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: Colors.black));

ThemeData blackTheme() => ThemeData(
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
    textTheme: const TextTheme(
      headline3: TextStyle(
          fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: Colors.white));
