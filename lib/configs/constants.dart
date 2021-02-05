import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/quick_links/quick_shopping.dart';
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
const String kNumberFontFamily = 'Roboto';

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
const String kPrimaryColorHex = "0xFFFDC500";
const Color kPrimaryAccentColor = Color(0x77FDC500);
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF333333);
const Color kGold = Color(0xFFF3C952);
const Color kTransparent = Colors.transparent;
const Color kBlackAccent = Colors.black45;

// Padding
const double kPaddingS = 4.0;
const double kPaddingM = 8.0;
const double kPaddingL = 20.0;

//Heights `collection
const double kTopDealsHeight = 80.0;
const double kButtonHeight = 45.0;
const double kSocialButtonHeight = kButtonHeight * 1.5;

/// Height beiween home strips
const double kPaddingBtwnStrips = 8.0;

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
  {'name': 'Staples', 'image': 'assets/images/categories/category1.png'},
  {'name': 'Snacks', 'image': 'assets/images/categories/category2.png'},
  {'name': 'Packed', 'image': 'assets/images/categories/category3.png'},
  {'name': 'Dairy', 'image': 'assets/images/categories/category4.png'},
  {'name': 'Fruits', 'image': 'assets/images/categories/cat5.png'},
  {'name': 'Vegetables', 'image': 'assets/images/categories/cat6.png'},
  {'name': 'Staples', 'image': 'assets/images/categories/cat7.png'},
  {'name': 'Beverages', 'image': 'assets/images/categories/cat8.png'},
  {'name': 'Category', 'image': 'assets/images/categories/cat9.png'},
  {'name': 'Example', 'image': 'assets/images/categories/cat10.png'},
];

/// Quick Links
const List<Map<String, String>> quickLinks = [
  {
    'name': 'Quick Shopping',
    'image': AssetImages.quickShopping,
    'link': QShoppingScreen.id,
  },
  {'name': 'Set Budget', 'image': AssetImages.setBudget, 'link': 'set_budget'},
  {'name': 'Cart', 'image': AssetImages.cart, 'link': 'cart'},
  {'name': 'My Orders', 'image': AssetImages.setBudget, 'link': 'my_order'},
];

// Quick Link Widgets
const Map<String, Widget> quickLinkWidgets = {
  QShoppingScreen.id: QShoppingScreen(),
};

/// Cart Bulk Buttons
const List<Map<String, int>> bulkAddToCart = [
  {"+ 5": 5},
  {"+ 10": 10},
  {"+ 20": 20},
  {"+ 50": 50},
  {"+ 100": 100},
];

/// Assets images
class AssetImages {
  static const String introScreen = 'assets/images/onboarding/IntroScreen.png';
  static const String onboardingWelcome = 'assets/images/onboarding/shop-1.png';
  static const String onboardingFind = 'assets/images/onboarding/barcode.png';
  static const String onboardingAppointment = 'assets/images/onboarding/qr.png';
  static const String homeWavyHeader = 'assets/images/home-page.jpg';
  static const String loginBackground = 'assets/images/illustration.jpg';
  static const String mapMarker = 'assets/images/map-marker.png';
  static const String icon = 'assets/images/icon_new.jpeg';
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

  static const String orDivider = 'assets/images/or.png';
  static const String cart = 'assets/images/cart.png';

  //Product Images
  static const String maggi = 'assets/images/products/maggi.jpeg';

  /// TopOffer Stock Images
  static String topOffers(int colIndex, int rowIndex) =>
      'assets/images/offers/Offer($colIndex,$rowIndex).png';

  static String checkoutImages(int index) =>
      'assets/images/checkout/checkout-$index.png';

  static String topDeals(int index) => 'assets/images/offers/Offer($index).png';

  static const String success_plane =
      'assets/images/checkout/success_plane.png';
  static const String success = 'assets/images/checkout/success.png';
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

enum CheckoutType { walkIn, pickUp, delivery }

const Map<CheckoutType, int> totalSteps = {
  CheckoutType.walkIn: 1,
  CheckoutType.pickUp: 2,
  CheckoutType.delivery: 3,
};

class CheckoutTypes {
  static String typeToString(CheckoutType type) {
    switch (type) {
      case CheckoutType.walkIn:
        return "Walk - In";
        break;
      case CheckoutType.pickUp:
        return "Self - Pickup";
        break;
      case CheckoutType.delivery:
        return "Deliver To Home";
        break;
      default:
        return "Unknown";
    }
  }

  static String typeDescription(CheckoutType type) {
    switch (type) {
      case CheckoutType.walkIn:
        return "Walk up to the counter and pay";
        break;
      case CheckoutType.pickUp:
        return "Your order will be packed, just visit the store, pay and collect";
        break;
      case CheckoutType.delivery:
        return "Your order will be delivered to your home directly";
        break;
      default:
        return "Unknown";
    }
  }
}
