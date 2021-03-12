// import 'package:camera/camera.dart';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/product/product.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/screens/search/voice_search.dart';
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
  GlobalKey<NavigatorState> globalKeyCustomNavigator;

  /// [GlobalKey] for checkout screen in [CheckoutNavigator].
  GlobalKey<NavigatorState> globalKeyCheckoutNavigator;

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

  /// Is speech recognition available on the device?
  bool hasSpeech = false;

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

  hideFAB(CartBloc bloc, bool hide) {
    bloc.add(SetFABEvent(hide: hide));
  }

  Future<void> showCartPage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9, child: CartPage()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
    );
  }

  // Functions to call for Cart operations
  final Function(Product, BuildContext, {VoidCallback then}) onProductPressed =
      (product, context, {then}) => showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ProductScreen(
                product: product,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            clipBehavior: Clip.antiAlias,
          ).then((value) {
            if (then != null) then();
          });
  final Function(Product, BuildContext, {int qty}) onProductAdd =
      (product, context, {int qty = 1}) => BlocProvider.of<CartBloc>(context)
          .add(AddPToCartEvent(product: product, qty: qty));
  final Function(Product, BuildContext) onProductRed = (product, context) =>
      BlocProvider.of<CartBloc>(context)
          .add(ReduceQOfPCartEvent(product: product));
  final Function(Product, BuildContext) onProductDel = (product, context) =>
      BlocProvider.of<CartBloc>(context)
          .add(RemovePFromCartEvent(product: product));

  /// Show search screen
  final Function(BuildContext) showSearchScreen = (context) =>
      showDialog(context: context, builder: (context) => SearchBar());

  /// Show Voice search
  final Function(BuildContext) showVoiceScreen = (context) => showDialog(
      context: context,
      builder: (context) => Dialog(child: VoiceSearch()),
      useRootNavigator: true);
}
