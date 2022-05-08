part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {
  const LocaleState(this.locale);
  final Locale locale;
}

class SelectedLocale extends LocaleState {
  const SelectedLocale(Locale locale) : super(locale);
}
