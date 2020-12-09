part of 'language_bloc.dart';

abstract class LanguageEvent {
  @override
  String toString() => '$runtimeType';
}

class ChangeRequestedLanguageEvent extends LanguageEvent {
  ChangeRequestedLanguageEvent(this.locale);

  final Locale locale;
}
