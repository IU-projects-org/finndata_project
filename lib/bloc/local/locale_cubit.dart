import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('en')));

  void toRussian() => emit(const SelectedLocale(Locale('ru')));

  void toEnglish() => emit(const SelectedLocale(Locale('en')));
}
