import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(InitialLanguageState());

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeRequestedLanguageEvent) {
      yield* _mapChangeLanguageEventToState(event);
    }
  }

  Stream<LanguageState> _mapChangeLanguageEventToState(
      ChangeRequestedLanguageEvent event) async* {
    yield UpdateInProgressLanguageState();

    getIt.get<AppGlobals>().selectedLocale = event.locale;

    await getIt.get<AppPreferences>().setString(
          PreferenceKey.language,
          event.locale.toString(),
        );

    yield UpdateSuccessLanguageState();
  }
}
