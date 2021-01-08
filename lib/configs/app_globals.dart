// import 'package:camera/camera.dart';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:breakq/configs/app_theme.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Class to store runtime global settings.
class AppGlobals {
  factory AppGlobals() => instance;

  AppGlobals._();

  /// Singleton instance.
  static final AppGlobals instance = AppGlobals._();

  /// List of available cameras on device.
  // List<CameraDescription> cameras;

  /// [GlobalKey] for our bottom bar.
  GlobalKey globalKeyBottomBar;

  /// [GlobalKey] for our [HomeScreen].
  GlobalKey globalKeyHomeScreen;

  /// [GlobalKey] for our [SearchScreen].
  GlobalKey globalKeySearchScreen;

  /// [GlobalKey] for tab bar in [SearchScreen].
  GlobalKey globalKeySearchTabs;

  /// [GlobalKey] for tab bar in [CustomNavigator].
  GlobalKey<NavigatorState> globalKeyNavigator;

  /// Dark Theme option
  DarkOption darkThemeOption = DarkOption.alwaysOff;

  /// User's current position.
  LocationData currentPosition;

  /// Business/Location categories.
  List<CategoryModel> categories;

  /// Logged in user data.
  User user;

  /// Currently selected [Locale].
  Locale selectedLocale;

  /// Is user onbaorded or this is their first run?
  bool isUserOnboarded;

  /// App is running on emulator (or real device)?
  // bool isAnEmulator;

  /// The current brightness mode of the host platform.
  Brightness get getPlatformBrightness {
    return SchedulerBinding.instance.window.platformBrightness;
  }

  /// Is the current brightness mode of the host platform dark?
  bool get isPlatformBrightnessDark {
    switch (darkThemeOption) {
      case DarkOption.alwaysOff:
        return false;
        break;
      case DarkOption.alwaysOn:
        return true;
      default:
        return Brightness.dark == getPlatformBrightness;
    }
  }

  // Functions to call for Cart operations
  final Function(Product, BuildContext) onProductPressed = (product,
      context) {}; //BlocProvider.of<CartBloc>(context).add(AddPToCartEvent(product: product))
  final Function(Product, BuildContext) onProductAdd = (product, context) =>
      BlocProvider.of<CartBloc>(context).add(AddPToCartEvent(product: product));
  final Function(Product, BuildContext) onProductRed = (product, context) =>
      BlocProvider.of<CartBloc>(context)
          .add(ReduceQOfPCartEvent(product: product));
  final Function(Product, BuildContext) onProductDel = (product, context) =>
      BlocProvider.of<CartBloc>(context)
          .add(RemovePFromCartEvent(product: product));
}
