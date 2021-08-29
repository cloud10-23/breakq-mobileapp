import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/blocs/product/offer_bloc.dart';
import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/blocs/search/search_bloc.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/checkout/checkout.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_1.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_3.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_screen_2.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_screen_1.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_screen_2.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_show_qr.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_success.dart';
import 'package:breakq/screens/edit_profile/take_picture.dart';
import 'package:breakq/screens/listing/listing.dart';
import 'package:breakq/screens/listing/offer_listing.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in_main.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in_mobile_num.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in_otp.dart';
import 'package:breakq/screens/onboarding/sign_up/sign_up.dart';
import 'package:breakq/screens/orders/help.dart';
import 'package:breakq/screens/orders/invoice.dart';
import 'package:breakq/screens/orders/my_orders.dart';
import 'package:breakq/screens/orders/order_details.dart';
import 'package:breakq/screens/product/product.dart';
import 'package:breakq/screens/quick_links/quick_shopping.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/widgets/add_address.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/edit_profile/edit_profile.dart';
import 'package:breakq/screens/empty.dart';
import 'package:breakq/widgets/photo_gallery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String o_home = '/';
  static const String o_mobileLogin = '/mobileLogin';
  static const String o_otp = '/mobileLogin/otp';
  static const String o_profile = '/profile';

  /// Product Listing
  static const String listing = '/listing';

  /// Offer Listing
  static const String offerListing = '/offer_listing';

  /// Product Details
  static const String product = '/product';

  /// Quick Shopping
  static const String quickShopping = '/qs';

  /// Search
  static const String search = '/search';

  /// Cart and Checkout
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String add_address = '/add_address';

  /// My Orders
  static const String orders = '/orders';
  static const String order_detail = '/orders/detail';
  static const String need_help = '/orders/detail/need_help';
  static const String order_invoice = '/orders/detail/invoice';

  /// Settings Page
  // static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String takePicture = '/takePicture';
  static const String locationGallery = '/locationGallery';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      /// Onboarding Routes:

      case o_home:
        return MaterialPageRoute<IntroMain>(
          builder: (BuildContext context) => IntroMain(),
        );
      case o_mobileLogin:
        return MaterialPageRoute<SignInWidget>(
          builder: (BuildContext context) => SignInWidget(
            title: routeSettings?.arguments,
          ),
        );
      case o_otp:
        return MaterialPageRoute<SignInOTPWidget>(
          builder: (BuildContext context) => SignInOTPWidget(),
        );
      case o_profile:
        return MaterialPageRoute<SignUpWidget>(
          builder: (BuildContext context) => SignUpWidget(),
        );

      /// Product Listing

      case listing:
        return MaterialPageRoute<Listing>(
          builder: (BuildContext context) => BlocProvider<ProductBloc>(
            create: (_) => ProductBloc()
              ..add(SessionInitedProductEvent(
                  category: routeSettings?.arguments)),
            child: Listing(
              category: routeSettings?.arguments,
            ),
          ),
        );

      /// Offer Listing
      case offerListing:
        return MaterialPageRoute<OfferListing>(
          builder: (BuildContext context) => BlocProvider<OfferBloc>(
            create: (_) => OfferBloc()
              ..add(SessionInitedProductEvent(offer: routeSettings?.arguments)),
            child: OfferListing(
              offer: routeSettings?.arguments,
            ),
          ),
        );

      /// Product details
      case product:
        return MaterialPageRoute<ProductScreen>(
          builder: (BuildContext context) {
            return ProductScreen(product: routeSettings.arguments);
          },
          settings: const RouteSettings(name: product),
        );

      /// Quick Shopping
      case quickShopping:
        return MaterialPageRoute<QShoppingScreen>(
          builder: (BuildContext context) {
            return QShoppingScreen();
          },
          settings: const RouteSettings(name: product),
        );

      /// Search
      case search:
        return MaterialPageRoute<SearchBar>(
          builder: (BuildContext context) => BlocProvider<SearchBloc>(
            create: (_) => SearchBloc()
              ..add(
                SessionInitedSearchEvent(),
              ),
            child: SearchBar(
              initialQuery: routeSettings.arguments,
            ),
          ),
        );

      /// Cart and Checkout
      case checkout:
        return MaterialPageRoute<CheckoutScreen>(
          builder: (BuildContext context) {
            return BlocProvider<CheckoutBloc>(
              create: (context) => CheckoutBloc(
                  cartBloc: BlocProvider.of<CartBloc>(context))
                ..add(LoadCartAndTypeChEvent(type: routeSettings.arguments)),
              child: CheckoutScreen(),
            );
          },
        );
      case cart:
        // return SlideRoute(widget: CartPage());
        return MaterialPageRoute<CartPage>(
          builder: (BuildContext context) => CartPage(),
        );
      case add_address:
        return SlideRoute(widget: AddEditAddress());

      /// My Orders
      case orders:
        return MaterialPageRoute<MyOrders>(
          builder: (BuildContext context) => MyOrders(),
        );
      case order_detail:
        return MaterialPageRoute<OrderDetails>(
          builder: (BuildContext context) => OrderDetails(
            checkoutType: routeSettings.arguments,
          ),
        );
      case need_help:
        return MaterialPageRoute<NeedHelp>(
          builder: (BuildContext context) => NeedHelp(),
        );
      case order_invoice:
        return MaterialPageRoute<Invoice>(
          builder: (BuildContext context) => Invoice(),
        );

      /// Settings Page
      case locationGallery:
        return MaterialPageRoute<PhotoGalleryScreen>(
          builder: (BuildContext context) {
            return PhotoGalleryScreen(
                params: routeSettings.arguments as Map<String, dynamic>);
          },
        );
      case editProfile:
        return MaterialPageRoute<EditProfileScreen>(
          builder: (BuildContext context) {
            return const EditProfileScreen();
          },
        );
      case takePicture:
        return MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return const TakePictureScreen();
          },
        );
      // case picker:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) {
      //       return Picker(
      //           params: routeSettings.arguments as Map<String, dynamic>);
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

// class OnboardingRoutes {
//   static const String home = '/';
//   static const String mobileLogin = '/mobileLogin';
//   static const String otp = '/mobileLogin/otp';
//   static const String profile = '/profile';
// }

// class OnboardingNavigator extends StatelessWidget {
//   OnboardingNavigator({this.navigatorKey, this.homeScreen});
//   final GlobalKey<NavigatorState> navigatorKey;
//   final Widget homeScreen;

//   Map<String, Function(BuildContext, RouteSettings)> _routeBuilders(
//       BuildContext context) {
//     return {
//       OnboardingRoutes.home: (context, settings) => homeScreen,
//       OnboardingRoutes.mobileLogin: (context, settings) => SignInWidget(
//           // : settings?.arguments ?? null,
//           ),
//       OnboardingRoutes.otp: (context, settings) => SignInOTPWidget(
//             phoneNumber: settings?.arguments ?? null,
//           ),
//       OnboardingRoutes.profile: (context, settings) => SignUpWidget(),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     var routeBuilders = _routeBuilders(context);
//     return Navigator(
//         key: navigatorKey,
//         initialRoute: OnboardingRoutes.home,
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
  static const String walkin_success = '/success';
  static const String pickup_success = '/pickup/success';
  static const String delivery_success = '/delivery/success';
}

class CheckoutNavigator extends StatelessWidget {
  CheckoutNavigator({
    this.navigatorKey,
    this.initialRoute = CheckoutNavigatorRoutes.walkin_1,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;

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
      CheckoutNavigatorRoutes.walkin_success: (context, settings) =>
          WalkinCheckoutSuccess(),
      CheckoutNavigatorRoutes.pickup_success: (context, settings) =>
          PickupCheckoutSuccessDialog(),
      CheckoutNavigatorRoutes.delivery_success: (context, settings) =>
          DeliveryCheckoutSuccessDialog()
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: initialRoute,
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
