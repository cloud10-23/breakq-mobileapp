import 'package:breakq/screens/product/product.dart';
import 'package:breakq/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/edit_profile/edit_profile.dart';
import 'package:breakq/screens/empty.dart';
import 'package:breakq/screens/favorites.dart';
import 'package:breakq/screens/photo_gallery.dart';
import 'package:breakq/screens/sign_up.dart';
import 'package:breakq/widgets/picker.dart';

/// Generate [MaterialPageRoute] for our screens.
class Routes {
  static const String location = '/location';
  static const String locationReviews = '/location/reviews';
  static const String locationGallery = '/location/gallery';
  static const String picker = '/picker';
  static const String searchMap = '/search/map';
  static const String forgotPassword = '/forgotPassword';
  static const String signIn = '/signIn';
  static const String signInOtp = '/signIn/otp';
  static const String signUp = '/signUp';
  static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String takePicture = '/takePicture';
  static const String favorites = '/favorites';
  static const String vouchers = '/vouchers';
  static const String voucher = '/voucher';
  static const String booking = '/booking';
  static const String bookingNotes = '/booking/notes';
  static const String appointment = '/appointment';
  static const String appointmentRating = '/appointment/rating';
  static const String appointmentRatingSuccess = '/appointment/rating/success';
  static const String ratings = '/ratings';
  static const String paymentCard = '/paymentCard';
  static const String addPaymentCard = '/paymentCard/add';
  static const String invite = '/invite';
  static const String wallet = '/wallet';

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case location:
        return MaterialPageRoute<LocationScreen>(
          builder: (BuildContext context) {
            return LocationScreen(locationId: routeSettings.arguments as int);
          },
          settings: const RouteSettings(name: location),
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
        return SlideRoute(widget: SignInScreen());
      // case signInOtp:
      //   return SlideRoute(widget: SignInScreenOTP());
      case signUp:
        return MaterialPageRoute<SignUpScreen>(
          builder: (BuildContext context) {
            return const SignUpScreen();
          },
        );
      case editProfile:
        return MaterialPageRoute<EditProfileScreen>(
          builder: (BuildContext context) {
            return const EditProfileScreen();
          },
        );
      // case takePicture:
      //   return MaterialPageRoute<String>(
      //     builder: (BuildContext context) {
      //       return const TakePictureScreen();
      //     },
      //   );
      case favorites:
        return MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return const FavoritesScreen();
          },
        );
      default:
        return MaterialPageRoute<EmptyScreen>(
          builder: (BuildContext context) {
            return const EmptyScreen();
          },
        );
    }
  }
}

class SlideRoute extends PageRouteBuilder {
  Widget widget;
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
