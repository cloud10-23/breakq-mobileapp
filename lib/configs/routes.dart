import 'package:breakq/screens/listing/listing.dart';
import 'package:breakq/screens/product/product.dart';
import 'package:breakq/screens/onboarding/sign_in.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/edit_profile/edit_profile.dart';
import 'package:breakq/screens/empty.dart';
import 'package:breakq/widgets/photo_gallery.dart';
import 'package:breakq/screens/onboarding/sign_up.dart';
import 'package:breakq/widgets/picker.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String product = '/product';
  static const String picker = '/picker';
  static const String forgotPassword = '/forgotPassword';
  static const String signIn = '/signIn';
  static const String signInOtp = '/signIn/otp';
  static const String signUp = '/signUp';
  static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String takePicture = '/takePicture';
  static const String locationGallery = '/locationGallery';
  static const String search = '/search';
  static const String scan = '/scan';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case product:
        return MaterialPageRoute<ProductScreen>(
          builder: (BuildContext context) {
            return ProductScreen(product: routeSettings.arguments);
          },
          settings: const RouteSettings(name: product),
        );
      case picker:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return Picker(
                params: routeSettings.arguments as Map<String, dynamic>);
          },
        );
      case locationGallery:
        return MaterialPageRoute<PhotoGalleryScreen>(
          builder: (BuildContext context) {
            return PhotoGalleryScreen(
                params: routeSettings.arguments as Map<String, dynamic>);
          },
        );
      case signIn:
        return SlideRoute(widget: const SignInScreen());
      case signUp:
        return SlideRoute(widget: const SignUpScreen());
      case editProfile:
        return MaterialPageRoute<EditProfileScreen>(
          builder: (BuildContext context) {
            return const EditProfileScreen();
          },
        );
      case search:
        return MaterialPageRoute<PhotoGalleryScreen>(
          builder: (BuildContext context) {
            return SearchBar();
          },
        );
      // case scan:
      //   return MaterialPageRoute<PhotoGalleryScreen>(
      //     builder: (BuildContext context) {
      //       return BarcodeScanner();
      //     },
      //   );
      // case takePicture:
      //   return MaterialPageRoute<String>(
      //     builder: (BuildContext context) {
      //       return const TakePictureScreen();
      //     },
      //   );
      default:
        return MaterialPageRoute<EmptyScreen>(
          builder: (BuildContext context) {
            return const EmptyScreen();
          },
        );
    }
  }
}

///
/// The Custom Navigation is required so that the Cart Overlay is persistant
/// even though we use `Navigator.push()` inside of `HomeScreen`
///
/// Refer this medium article for more info:
/// https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf
///

class CustomNavigatorRoutes {
  static const String home = '/';
  static const String listing = '/listing';
}

class CustomNavigator extends StatelessWidget {
  CustomNavigator({this.navigatorKey, this.homeScreen});
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget homeScreen;

  Map<String, Function(BuildContext, RouteSettings)> _routeBuilders(
      BuildContext context) {
    return {
      CustomNavigatorRoutes.home: (context, settings) => homeScreen,
      CustomNavigatorRoutes.listing: (context, settings) => Listing(
            title: settings?.arguments ?? null,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: CustomNavigatorRoutes.home,
        onGenerateRoute: (routeSettings) {
          return SlideRoute(
              widget:
                  routeBuilders[routeSettings.name](context, routeSettings));
        });
  }
}

class SlideRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRoute({this.widget})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var tween, curve, animationWithCurve;
              tween = Tween(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              );
              curve = Curves.easeOut;
              animationWithCurve = CurvedAnimation(
                parent: animation,
                curve: curve,
              );
              return SlideTransition(
                position: tween.animate(animationWithCurve),
                child: child,
              );
            });
}
