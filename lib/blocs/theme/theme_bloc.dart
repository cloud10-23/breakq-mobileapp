import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    /// Update theme style and font.
    if (event is ChangeRequestedThemeEvent) {
      yield* _mapChangeThemeEventToState(event);
    }
  }

  Stream<ThemeState> _mapChangeThemeEventToState(
      ChangeRequestedThemeEvent event) async* {
    yield UpdateInProgressThemeState();

    getIt.get<AppGlobals>().darkThemeOption =
        event.darkOption ?? DarkOption.alwaysOff;

    final AppTheme theme = AppTheme();

    switch (getIt.get<AppGlobals>().darkThemeOption) {
      case DarkOption.dynamic:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
      case DarkOption.alwaysOn:
        getIt.get<AppTheme>().lightTheme = theme.darkTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
      case DarkOption.alwaysOff:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.lightTheme;
        break;
      default:
        getIt.get<AppTheme>().lightTheme = theme.lightTheme;
        getIt.get<AppTheme>().darkTheme = theme.darkTheme;
        break;
    }

    await getIt.get<AppPreferences>().setString(PreferenceKey.darkOption,
        getIt.get<AppGlobals>().darkThemeOption.toString());

    yield UpdateSuccessThemeState();
  }
}
