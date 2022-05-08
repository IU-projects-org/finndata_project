import 'package:bloc/bloc.dart';
import 'package:finndata_project/constants/app_constants.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(appSettings.language == 'English'
            ? const SelectedLocale(Locale('en'))
            : const SelectedLocale(Locale('ru')));

  void toRussian() => emit(const SelectedLocale(Locale('ru')));

  void toEnglish() => emit(const SelectedLocale(Locale('en')));
}
