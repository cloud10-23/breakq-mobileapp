// import 'package:camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:breakq/blocs/app_observer.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main_app.dart';
import 'package:breakq/utils/app_preferences.dart';
import 'package:location/location.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Init service locator singletons.
  initServiceLocator();

  // Obtain a list of the available cameras on the device.
  initCameras();

  /// The App's [BlocObserver].
  Bloc.observer = AppObserver();
  // BlocOverrides.runZoned(
  //   () {},
  //   blocObserver: AppObserver(),
  // );

  /// For setting the status bar color:
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    // statusBarBrightness: Brightness.light, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
  ));

  /// Initialise Firebase Core
  await Firebase.initializeApp();

  // Inflate the MainApp widget.
  runApp(MainApp());
}

/// Completes with a list of available cameras.
Future<void> initCameras() async {
  /// Obtain a list of the available cameras on the device.
  final List<CameraDescription> cameras = await availableCameras();

  /// Save the list of available cameras.
  getIt.get<AppGlobals>().cameras = cameras;
}

/// Registers all the singletons we need by passing a factory function.
void initServiceLocator() {
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences());
  getIt.registerLazySingleton<AppTheme>(() => AppTheme());
  getIt.registerLazySingleton<AppGlobals>(() => AppGlobals());
  getIt.registerLazySingleton<Location>(() => Location());
}
