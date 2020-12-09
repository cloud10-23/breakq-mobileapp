part of 'language_bloc.dart';

abstract class LanguageState {
  @override
  String toString() => '$runtimeType';
}

class InitialLanguageState extends LanguageState {}

class UpdateInProgressLanguageState extends LanguageState {}

class UpdateSuccessLanguageState extends LanguageState {}
