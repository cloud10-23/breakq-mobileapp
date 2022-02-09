import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/orders/orders_bloc.dart';
import 'package:breakq/blocs/quick_shopping/qs_bloc.dart';
import 'package:breakq/data/repositories/user_repository.dart';
import 'package:breakq/screens/home/base.dart';
import 'package:breakq/screens/onboarding/onboarding.dart';
import 'package:breakq/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';

import 'blocs/application/application_bloc.dart';

import 'generated/l10n.dart';
import 'main.dart';

/// The global RouteObserver.
final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

ApplicationBloc _applicationBloc;
AuthBloc _authBloc;
HomeBloc _homeBloc;
BudgetBloc _budgetBloc;
OrdersBloc _ordersBloc;
CartBloc _cartBloc;
QSBloc _qsBloc;

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
    _initBlocs();

    super.initState();
  }

  /// Init all [Bloc]s here.
  void _initBlocs() async {
    _homeBloc = HomeBloc();
    _budgetBloc = BudgetBloc();
    _cartBloc = CartBloc(
      budgetBloc: _budgetBloc,
      homeBloc: _homeBloc,
    );
    _authBloc = AuthBloc(
      userRepository: UserRepository(),
    );
    _qsBloc = QSBloc(cartBloc: _cartBloc);
    _ordersBloc = OrdersBloc(qsBloc: _qsBloc);
    _applicationBloc = ApplicationBloc(
      authBloc: _authBloc,
    );
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);

    _authBloc.close();
    _homeBloc.close();
    _cartBloc.close();
    _qsBloc.close();
    _budgetBloc.close();
    _ordersBloc.close();
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
        BlocProvider<HomeBloc>(create: (BuildContext context) => _homeBloc),
        BlocProvider<CartBloc>(create: (BuildContext context) => _cartBloc),
        BlocProvider<QSBloc>(create: (BuildContext context) => _qsBloc),
        BlocProvider<BudgetBloc>(create: (BuildContext context) => _budgetBloc),
        BlocProvider<OrdersBloc>(create: (BuildContext context) => _ordersBloc),
      ],
      child: BlocConsumer<ApplicationBloc, ApplicationState>(
        listenWhen: (previous, current) =>
            current is SetupSuccessApplicationState,
        listener: (context, state) {
          _homeBloc.add(SessionInitedHomeEvent());
          _cartBloc.add(InitCartEvent());
          _ordersBloc.add(LoadOrdersEvent());
        },
        buildWhen:
            (ApplicationState previousState, ApplicationState currentState) =>
                (currentState is LifecycleChangeInProgressApplicationState &&
                    currentState.state == AppLifecycleState.resumed) ||
                currentState is! LifecycleChangeInProgressApplicationState,
        builder: (BuildContext context, ApplicationState appState) {
          Widget homeWidget;

          if (appState is SetupSuccessApplicationState) {
            homeWidget = Base();
          } else if (appState is OnboardingInProgressApplicationState) {
            homeWidget = const OnboardingScreen();
          } else {
            homeWidget = const SplashScreen();
          }

          return BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                current is LogoutSuccessAuthState,
            listener: (context, state) =>
                _applicationBloc.add(SetupApplicationEvent()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: L10n.delegate.supportedLocales,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                L10n.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
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
      ),
    );
  }
}
