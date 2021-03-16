import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/checkout/checkout.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_1.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_3.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_2.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_screen_1.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_screen_2.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_show_qr.dart';
import 'package:breakq/screens/listing/listing.dart';
import 'package:breakq/screens/orders/my_orders.dart';
import 'package:breakq/screens/orders/order_details.dart';
import 'package:breakq/screens/product/product.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in.dart';
import 'package:breakq/screens/quick_links/quick_shopping.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/widgets/add_address.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/edit_profile/edit_profile.dart';
import 'package:breakq/screens/empty.dart';
import 'package:breakq/widgets/photo_gallery.dart';
import 'package:breakq/screens/onboarding/sign_up.dart';
import 'package:breakq/widgets/picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String product = '/product';
  static const String picker = '/picker';
  static const String forgotPassword = '/forgotPassword';
  static const String signIn = '/signIn';
  static const String signInOtp = '/signIn/otp';
  static const String signUp = '/signUp';
  static const String quickShopping = '/qs';
  static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String takePicture = '/takePicture';
  static const String locationGallery = '/locationGallery';
  static const String search = '/search';
  static const String scan = '/scan';
  static const String checkout = '/checkout';
  static const String cart = '/cart';
  static const String add_address = '/add_address';
  static const String orders = '/orders';
  static const String order_detail = '/orders/detail';
  static const String listing = '/listing';

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
      case quickShopping:
        return MaterialPageRoute<ProductScreen>(
          builder: (BuildContext context) {
            return QShoppingScreen();
          },
          settings: const RouteSettings(name: product),
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
        return MaterialPageRoute<SearchBar>(
          builder: (BuildContext context) {
            return SearchBar();
          },
        );
      case checkout:
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) {
            return BlocProvider<CheckoutBloc>(
              create: (context) =>
                  CheckoutBloc(cartBloc: BlocProvider.of<CartBloc>(context)),
              child: CheckoutScreen(),
            );
          },
        );
      case cart:
        // return SlideRoute(widget: CartPage());
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) => CartPage(),
        );
      case add_address:
        return SlideRoute(widget: AddEditAddress());
      case orders:
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) => MyOrders(),
        );
      case order_detail:
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) => OrderDetails(),
        );

      case listing:
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) => Listing(
            title: routeSettings?.arguments ?? null,
          ),
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

// class CustomNavigatorRoutes {
//   static const String home = '/';
//   static const String listing = '/listing';
//   static const String qs = '/quick_shopping';
// }

// class CustomNavigator extends StatelessWidget {
//   CustomNavigator({this.navigatorKey, this.homeScreen});
//   final GlobalKey<NavigatorState> navigatorKey;
//   final Widget homeScreen;

//   Map<String, Function(BuildContext, RouteSettings)> _routeBuilders(
//       BuildContext context) {
//     return {
//       CustomNavigatorRoutes.home: (context, settings) => homeScreen,
//       CustomNavigatorRoutes.listing: (context, settings) => Listing(
//             title: settings?.arguments ?? null,
//           ),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     var routeBuilders = _routeBuilders(context);
//     return Navigator(
//         key: navigatorKey,
//         initialRoute: CustomNavigatorRoutes.home,
//         onGenerateRoute: (routeSettings) {
//           return SlideRoute(
//               widget:
//                   routeBuilders[routeSettings.name](context, routeSettings));
//         });
//   }
// }

/// The custom navigator for checkout screens:
class CheckoutNavigatorRoutes {
  // static const String base = '/';
  static const String walkin_1 = '/';
  static const String pickup_1 = '/pickup';
  static const String pickup_2 = '/pickup/confirm';
  static const String delivery_1 = '/delivery';
  static const String delivery_2 = '/delivery/timeslot';
  static const String delivery_3 = '/delivery/confirm';
  static const String add_address = '/add_address';
}

class CheckoutNavigator extends StatelessWidget {
  CheckoutNavigator({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  Map<String, Function(BuildContext, RouteSettings)> _routeBuilders(
      BuildContext context) {
    return {
      // CheckoutNavigatorRoutes.base: (context, settings) => CheckoutBaseStep(),
      CheckoutNavigatorRoutes.walkin_1: (context, settings) => ChWalkInShowQr(),
      CheckoutNavigatorRoutes.pickup_1: (context, settings) => ChPickup(),
      CheckoutNavigatorRoutes.pickup_2: (context, settings) =>
          ChPickupConfirm(),
      CheckoutNavigatorRoutes.delivery_1: (context, settings) => ChDelivery(),
      CheckoutNavigatorRoutes.delivery_2: (context, settings) =>
          ChDeliverySlot(),
      CheckoutNavigatorRoutes.delivery_3: (context, settings) =>
          ChDeliveryConfirm(),
      CheckoutNavigatorRoutes.add_address: (context, settings) =>
          AddEditAddress(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: CheckoutNavigatorRoutes.walkin_1,
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
