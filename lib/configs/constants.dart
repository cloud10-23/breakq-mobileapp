import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
const String kDateTimeFormat = 'MMM d, y';
const String kTimeFormat = 'h:mm a';

// Various Sizes
const double kBottomBarIconSize = 32.0;
const double kBoxDecorationRadius = 8.0;
const double kFormFieldsRadius = 6.0;
const double kRoundedButtonRadius = 24.0;
const double kCardRadius = 15.0;
const double kBadgeRadius = 16.0;
const double kTimelineDateSize = 70.0;

// Colors
const Color kPrimaryColor = kBlue; // Color(0xFFFDC500); //Color(0xFF1565C0);
const String kPrimaryColorHex = "1565C0";
const Color kPrimaryAccentColor = Color(0x77FDC500);
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF333333);
const Color kGold = Color(0xFFF3C952);
const Color kTransparent = Colors.transparent;
const Color kBlackAccent = Colors.black45;
const Color kHyperLinkColor = Color(0xFF0645AD);

const Color kBlue = Color(0xFF1565C0);
const Color kBlue200 = Color(0xFF90CAF9);
const Color kBlue300 = Color(0xFF64B5F6);
const Color kBlue700 = Color(0xFF1976D2);
const Color kBlue900 = Color(0xFF0D47A1);

const Color kGreen = Color(0xFF2E7D32);

const List<Map<String, Color>> checkoutRadioColors = [
  {
    "main": Color(0xFFBDD1F2),
    "sub": Color(0xFFA7C2EA),
  },
  {
    "main": Color(0xFFB9D8DA),
    "sub": Color(0xFFA1CBCD),
  },
  {
    "main": Color(0xFFBDDDF2),
    "sub": Color(0xFFA7D1F0),
  },
];

// Padding
const double kPaddingS = 4.0;
const double kPaddingM = 8.0;
const double kPaddingL = 20.0;

//Heights `collection
const double kTopDealsHeight = 80.0;
const double kButtonHeight = 45.0;
const double kSocialButtonHeight = kButtonHeight * 1.5;

/// Height beiween home strips
const double kPaddingBtwnStrips = 15.0;

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
const String kCurrencySymbol = '₹';

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
const List<Map<String, dynamic>> quickLinks = [
  {
    'name': 'Quick Shopping',
    'icon': Entypo.flash,
    'link': Routes.quickShopping,
  },
  {
    'name': 'Set Budget',
    'icon': FontAwesome5Solid.money_bill,
    'link': "SetBudget",
  },
  {'name': 'Cart', 'icon': FontAwesome.shopping_cart, 'link': Routes.cart},
  {'name': 'My Orders', 'icon': FontAwesome.archive, 'link': Routes.orders},
];

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
  static const String onboardingShopImage =
      'assets/images/icons/BQ_Logo_Text.png';
  static const String onboardingBarcode =
      'assets/images/onboarding/barcode.png';
  static const String onboardingQR = 'assets/images/onboarding/qr.png';
  static const String homeWavyHeader = 'assets/images/home-page.jpg';
  static const String loginBackground =
      'assets/images/illustrations/illustration.jpg';
  static const String cartIllustration =
      'assets/images/illustrations/cart-illustration.jpg';
  static const String homeIllustration =
      'assets/images/illustrations/home-illustration-2.jpg';
  static const String qsIllustration =
      'assets/images/illustrations/qs_illustration.svg';
  static const String checkoutWalkinIllustration =
      'assets/images/illustrations/checkout_3.jpg';
  static const String checkoutSelfPickupIllustration =
      'assets/images/illustrations/checkout_2.jpg';
  static const String checkoutDeliveryIllustration =
      'assets/images/illustrations/checkout_delivery.jpg';
  // 'assets/images/illustrations/checkout-illustration.png';
  static const String addressIllustration =
      'assets/images/illustrations/address_illustration.svg';
  static const String orderIllustration =
      'assets/images/illustrations/orders-illustration.jpg';
  static const String martIllustration =
      'assets/images/illustrations/shopping_mart_illustration.jpeg';

  static const List<String> errors = [
    'assets/images/illustrations/error.png',
    'assets/images/illustrations/no_data.png',
    'assets/images/illustrations/noInternet.jpg',
    'assets/images/illustrations/no_result.png',
    // 'assets/images/illustrations/noData.png',
  ];

  static const String cartEmpty = 'assets/images/empty_cart.jpeg';
  static const String mapMarker = 'assets/images/map-marker.png';
  static const String icon = 'assets/images/icon_new.jpeg';
  static const String bq_logo = 'assets/images/bq_logo.png';
  static const String bq_icon = 'assets/images/icons/BQ_Logo_Plane.png';
  static const String bq_icon_alt = 'assets/images/icons/BQ_Logo_Plane_Alt.png';
  static const String bq_icon_text = 'assets/images/icons/BQ_Logo_Text.png';
  static const String mts_logo = 'assets/images/mts_logo_compact.png';
  static const String chip = 'assets/images/cc/chip.png';
  static const String cardVisa = 'assets/images/cc/visa.png';
  static const String cardAmex = 'assets/images/cc/amex.png';
  static const String cardDiscover = 'assets/images/cc/discover.png';
  static const String cardMastercard = 'assets/images/cc/mastercard.png';
  static const String profileDefault = 'assets/images/icons/profile.png';
  // static const String homeOffers = 'assets/images/offers/main_offer.png';
  static const String homeOffers = 'assets/images/offers/banner.png';

  static const String break_the_queue =
      'assets/images/illustrations/break_the_queue.png';

  static const String cat = 'assets/images/categories/cat';

  static const String productPlaceholder =
      'assets/images/products/product-image-placeholder.jpg';

  static const String shop = 'assets/images/icons/store_icon.jpeg';

  // static const String cartIcon = 'assets/images/icons/quick_shopping_3_c.png';

  static const String quickShopping =
      'assets/images/icons/quick_shopping_blue.png';
  static const String setBudget = 'assets/images/icons/piggy.png';
  static const String myOrders = 'assets/images/icons/wallet.png';
  static const String cart = 'assets/images/icons/cart.png';

  static const String notification = 'assets/images/icons/loudspeaker_a.png';

  static const String orDivider = 'assets/images/or.png';
  static const String scan = 'assets/images/Scan.png';

  //Product Images
  static const String ariel = 'assets/images/products/ariel.jpg';
  static const String tide = 'assets/images/products/tide.jpg';
  static const String surfexcel = 'assets/images/products/surf_excel.jpg';
  static const String henko = 'assets/images/products/henko.jpg';

  /// Banners
  // static const String banner_qs = 'assets/images/banners/B1.png';
  // static const String banner_to = 'assets/images/banners/B2.png';
  // static const String banner_td = 'assets/images/banners/B3.png';

  // static const String banner_exc2 = 'assets/images/banners/Exclusive4.png';
  // static const String banner_cat = 'assets/images/banners/Categories3.png';
  // static const String banner_brick = 'assets/images/banners/brick.jpg';

  // static const String banner = 'assets/images/banners/banner-4.jpg';

  /// TopOffer Stock Images
  static String topOffers(int index) => 'assets/images/offers/${index + 1}.png';

  static String banner(int index) => 'assets/images/offers/banner$index.png';

  static String checkoutImages(int index) =>
      'assets/images/checkout/checkout-$index.png';

  static String topDeals(int index) => 'assets/images/offers/Offer($index).png';

  static const String success_plane =
      'assets/images/checkout/success_plane.png';
  static const String success = 'assets/images/checkout/success.png';

  static const String paid_image = 'assets/images/icons/paid_green.png';

  static String ads(int index) => 'assets/images/ads/ad$index.jpeg';
}

enum homeSections {
  topOffers,
  topDeals,
  offersForYou,
  exclProducts,
  categories
}

/// Sort Types
const List<dynamic> sortTypes = <dynamic>[
  // <String, dynamic>{
  //   'code': 'rating',
  //   'label': "Top Rated",
  //   'icon': Icons.star,
  // },
  // <String, dynamic>{
  //   'code': 'popularity',
  //   'label': "Most Popular",
  //   'icon': Icons.remove_red_eye,
  // },
  <String, dynamic>{
    'code': apiSortHTL,
    'label': "Price:  High-Low",
    'icon': Icons.attach_money,
  },
  <String, dynamic>{
    'code': apiSortLTH,
    'label': "Price:  Low-High",
    'icon': Icons.attach_money,
  },
];

/// GLOBAL non-constant variable List Types
List<dynamic> listTypes = <dynamic>[
  <String, dynamic>{
    'code': describeEnum(ProductListItemViewType.grid),
    'label': '',
    'icon': Ionicons.ios_list,
  },
  <String, dynamic>{
    'code': describeEnum(ProductListItemViewType.list),
    'label': '',
    'icon': Icons.view_comfy,
  },
];

/// Sample Products for display
Map<Product, int> generateSampleProducts() => {
      Product(
        id: 100,
        image: AssetImages.ariel,
        salePrice: 60,
        maxPrice: 40,
        quantity: '500 gm',
        title: 'Ariel',
      ): 2,
      Product(
        id: 101,
        image: AssetImages.tide,
        salePrice: 100,
        maxPrice: 70,
        quantity: '500 ml',
        title: 'Tide',
      ): 4,
      Product(
        id: 102,
        image: AssetImages.surfexcel,
        salePrice: 500,
        maxPrice: 490,
        quantity: '5 kg',
        title: 'Surf Excel',
      ): 1,
      Product(
        id: 102,
        image: AssetImages.henko,
        salePrice: 500,
        maxPrice: 490,
        quantity: '5 kg',
        title: 'Henko',
      ): 1,
    };

/// Sample price details

Price generateSamplePrice() => Price(
    totalAmount: 660,
    discount: 50,
    finalAmount: 650,
    extraOffer: 10,
    savings: 10,
    delivery: 50);

/// Preference keys used to store/read values using [AppPreferences].
class PreferenceKey {
  static const String appVersion = 'appVersion';
  static const String isOnboarded = 'isOnboarded';
  static const String phoneID = 'phoneID';
  static const String socialID = 'socialID';
  static const String language = 'language';
  static const String notification = 'notification';
  static const String darkOption = 'darkOption';
  static const String recentlyScanned = 'recentlyScanned';
  static const String stores = 'stores';
}

enum CheckoutType { walkIn, pickUp, delivery }

const Map<CheckoutType, int> totalSteps = {
  CheckoutType.walkIn: 1,
  CheckoutType.pickUp: 0,
  CheckoutType.delivery: 1,
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

  static CheckoutType fromAPItypeToEnum(String type) {
    switch (type) {
      case 'W':
        return CheckoutType.walkIn;
        break;
      case 'S':
        return CheckoutType.pickUp;
        break;
      case 'D':
        return CheckoutType.delivery;
        break;
      default:
        return CheckoutType.walkIn;
    }
  }

  static String fromAPItypeToString(String type) {
    switch (type) {
      case 'W':
        return "Walk - In";
        break;
      case 'S':
        return "Self - Pickup";
        break;
      case 'D':
        return "Deliver To Home";
        break;
      default:
        return "ERR";
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
