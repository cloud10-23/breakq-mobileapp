import 'package:breakq/data/repositories/user_repository.dart';
import 'package:breakq/screens/home/explore.dart';
import 'package:breakq/screens/onboarding.dart';
import 'package:breakq/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/blocs/language/language_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/blocs/theme/theme_bloc.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/utils/localization.dart';
import 'package:breakq/widgets/bottom_navigation.dart';

import 'blocs/application/application_bloc.dart';

import 'generated/l10n.dart';
import 'main.dart';

/// The global RouteObserver.
final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

ApplicationBloc _applicationBloc;
AuthBloc _authBloc;
HomeBloc _searchBloc;
LanguageBloc _languageBloc;
ThemeBloc _themeBloc;

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> /*with WidgetsBindingObserver */ {
  @override
  void initState() {
    /// The glue between the widgets layer and the Flutter engine.
    // WidgetsBinding.instance.addObserver(this);

    getIt.get<AppGlobals>().globalKeyBottomBar =
        GlobalKey(debugLabel: 'bottom_bar');
    getIt.get<AppGlobals>().globalKeyHomeScreen =
        GlobalKey(debugLabel: 'home_screen');
    getIt.get<AppGlobals>().globalKeySearchScreen =
        GlobalKey(debugLabel: 'search_screen');

    _initBlocs();

    super.initState();
  }

  /// Init all [Bloc]s here.
  void _initBlocs() async {
    _authBloc = AuthBloc(userRepository: UserRepository());
    _searchBloc = HomeBloc();
    _languageBloc = LanguageBloc();
    _themeBloc = ThemeBloc();

    _applicationBloc = ApplicationBloc(
      authBloc: _authBloc,
      languageBloc: _languageBloc,
      themeBloc: _themeBloc,
    );
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);

    _authBloc.close();
    _searchBloc.close();
    _languageBloc.close();
    _themeBloc.close();
    _applicationBloc.close();
    super.dispose();
  }

  /// Called when the system puts the app in the background or returns the app
  /// to the foreground.
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (getIt.get<AppGlobals>().isUserOnboarded) {
  //     /// Notify ApplicationBloc with a new [LifecycleChangedApplicationEvent].
  //     _applicationBloc.add(LifecycleChangedApplicationEvent(state: state));
  //   }

  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ApplicationBloc>(
            create: (BuildContext context) => _applicationBloc),
        BlocProvider<AuthBloc>(create: (BuildContext context) => _authBloc),
        BlocProvider<HomeBloc>(create: (BuildContext context) => _searchBloc),
        // BlocProvider<LanguageBloc>(
        //     create: (BuildContext context) => _languageBloc),
        BlocProvider<ThemeBloc>(create: (BuildContext context) => _themeBloc),
      ],
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        buildWhen:
            (ApplicationState previousState, ApplicationState currentState) =>
                (currentState is LifecycleChangeInProgressApplicationState &&
                    currentState.state == AppLifecycleState.resumed) ||
                currentState is! LifecycleChangeInProgressApplicationState,
        builder: (BuildContext context, ApplicationState appState) {
          Widget homeWidget;

          // if (appState is SetupSuccessApplicationState) {
          //   // homeWidget = HomeExploreScreen();
          homeWidget = HomeExploreScreen(
              key: getIt.get<AppGlobals>().globalKeySearchScreen);
          // } else if (appState is OnboardingInProgressApplicationState) {
          //   homeWidget = OnboardingScreen();
          // } else {
          //   homeWidget = const SplashScreen();
          // }

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (BuildContext context, ThemeState theme) {
              return BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    current is LogoutSuccessAuthState,
                listener: (context, state) =>
                    _applicationBloc.add(SetupApplicationEvent()),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  supportedLocales: L10n.delegate.supportedLocales,
                  localizationsDelegates: const <
                      LocalizationsDelegate<dynamic>>[
                    L10n.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate, // Needed for iOS!
                    FallbackCupertinoLocalisationsDelegate(),
                  ],
                  localeResolutionCallback:
                      (Locale locale, Iterable<Locale> supportedLocales) =>
                          kDefaultLocale,
                  navigatorObservers: <NavigatorObserver>[routeObserver],
                  onGenerateRoute: Routes().generateRoute,
                  theme: getIt.get<AppTheme>().lightTheme,
                  darkTheme: getIt.get<AppTheme>().darkTheme,
                  themeMode: ThemeMode.light,
                  home: homeWidget,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
