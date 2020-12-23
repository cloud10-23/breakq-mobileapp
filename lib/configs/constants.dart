import 'package:flutter/material.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';

typedef ToolbarOptionModelCallback = void Function(
    ToolbarOptionModel sortModel);

const String kAppName = 'BreakQ';
const String kAppVersion = '1.0.0';

/// Default theme font.
///
/// Use null for system font or font name declared in pubspec.yaml like Roboto
/// or Raleway.
const String kFontFamily = 'Raleway';

// Date/time formats
const String kDateFormat = 'MMM d, y';
const String kDateTimeFormat = 'MMM d, y HH:mm';
const String kTimeFormat = 'HH:mm';

// Various Sizes
const double kBottomBarIconSize = 32.0;
const double kBoxDecorationRadius = 8.0;
const double kFormFieldsRadius = 6.0;
const double kRoundedButtonRadius = 24.0;
const double kCardRadius = 24.0;
const double kBadgeRadius = 16.0;
const double kTimelineDateSize = 88.0;

// Colors
const Color kPrimaryColor = Color(0xFFFDC500);
const Color kPrimaryAccentColor = Color(0x77FDC500);
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF333333);
const Color kGold = Color(0xFFF3C952);
const Color kTransparent = Colors.transparent;

// Padding
const double kPaddingS = 10.0;
const double kPaddingM = 20.0;
const double kPaddingL = 40.0;

// Avatar sizes
const double kCircleAvatarSizeRadiusAppBar = 20.0;
const double kCircleAvatarSizeRadiusSmall = 24.0;
const double kCircleAvatarSizeRadiusLarge = 48.0;

// Animations
const Duration kRippleAnimationDuration = Duration(milliseconds: 600);
const Duration kButtonAnimationDuration = Duration(milliseconds: 200);
const Duration kPaymentCardAnimationDuration = Duration(milliseconds: 500);

/// Reservations date range in days.
const int kReservationsDateRange = 7;

/// Reservations per page.
const int kReservationsPerPage = 10;

/// Reviews per page.
const int kReviewsPerPage = 10;

/// Minimal query string length.
const int kMinimalNameQueryLength = 3;

/// Minimal password string length.
const int kMinimalPasswordLength = 8;

/// SnackBar duration in miliseconds (short).
const int kSnackBarDurationShort = 2500;

/// SnackBar duration in miliseconds (long).
const int kSnackBarDurationLong = 10000;

// Default geo position
const double kDefaultLat = 37.789682;
const double kDefaultLon = -122.3923026;

/// Default locale.
const Locale kDefaultLocale = Locale('en');

/// Review comment length limit.
const int kReviewLengthLimit = 400;

/// Terms of service URL.
const String kTermsOfServiceURL = 'https://themeforest.net/legal/market';

/// Privacy policy URL.
const String kPrivacyPolicyURL = 'https://envato.com/privacy/';

/// Template homepage URL.
const String kHomepageURL = 'https://codecanyon.net/user/zoranjuric';

/// Password match regex string.
///
/// - Require that at least one digit appear anywhere in the string
/// - Require that at least one uppercase letter appear anywhere in the string
/// - The password must be at least 8 characters long
const String kPasswordRegex = r'^(?=.*[0-9])(?=.*[A-Z]).{8,}$';

/// Demo account email address.
const String kDemoEmail = 'admin@example.com';

/// Demo account password.
const String kDemoPassword = 'Password1';

/// Currency used in the application.
const String kCurrency = 'INR';

/// My separate constants, for later adding to .arb file
const String allServices = "All Services";

/// Default cancelation policy
const String cancelationPolicy = "Cancel for free anytime in advance, " +
    "otherwise you can be charged 10% of the service price for not showing up.";

/// Categories
const List<Map<String, String>> categories = [
  {'name': 'Staples', 'image': 'assets/images/categories/cat1.png'},
  {'name': 'Snacks', 'image': 'assets/images/categories/cat2.png'},
  {'name': 'Packed', 'image': 'assets/images/categories/cat3.png'},
  {'name': 'Dairy', 'image': 'assets/images/categories/cat4.png'},
  {'name': 'Fruits', 'image': 'assets/images/categories/cat5.png'},
  {'name': 'Vegetables', 'image': 'assets/images/categories/cat6.png'},
  {'name': 'Staples', 'image': 'assets/images/categories/cat7.png'},
  {'name': 'Beverages', 'image': 'assets/images/categories/cat8.png'},
  {'name': 'Category', 'image': 'assets/images/categories/cat9.png'},
  {'name': 'Example', 'image': 'assets/images/categories/cat10.png'},
];

/// Assets images
class AssetsImages {
  static const String introScreen = 'assets/images/onboarding/IntroScreen.png';
  static const String onboardingWelcome = 'assets/images/onboarding/shop-1.png';
  static const String onboardingFind = 'assets/images/onboarding/barcode.png';
  static const String onboardingAppointment = 'assets/images/onboarding/qr.png';
  static const String homeWavyHeader = 'assets/images/home-page.jpg';
  static const String loginBackground = 'assets/images/illustration.jpg';
  static const String mapMarker = 'assets/images/map-marker.png';
  static const String icon = 'assets/images/icon.png';
  static const String chip = 'assets/images/cc/chip.png';
  static const String cardVisa = 'assets/images/cc/visa.png';
  static const String cardAmex = 'assets/images/cc/amex.png';
  static const String cardDiscover = 'assets/images/cc/discover.png';
  static const String cardMastercard = 'assets/images/cc/mastercard.png';
  static const String profileDefault = 'assets/images/profile.png';
  static const String homeOffers = 'assets/images/offers.jpeg';

  static const String cat = 'assets/images/categories/cat';

  static const String quickShopping = 'assets/images/quick_shopping.png';
  static const String setBudget = 'assets/images/orders.png';
  static const String scan = 'assets/images/Scan.png';
}

/// Preference keys used to store/read values using [AppPreferences].
class PreferenceKey {
  static const String appVersion = 'appVersion';
  static const String isOnboarded = 'isOnboarded';
  static const String user = 'user';
  static const String language = 'language';
  static const String notification = 'notification';
  static const String darkOption = 'darkOption';
}
