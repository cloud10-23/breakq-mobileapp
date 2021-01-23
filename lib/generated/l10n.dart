// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class L10n {
  L10n();
  
  static L10n current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      L10n.current = L10n();
      
      return L10n.current;
    });
  } 

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Hi, `
  String get homeTitleHi {
    return Intl.message(
      'Hi, ',
      name: 'homeTitleHi',
      desc: '',
      args: [],
    );
  }

  /// `Hi, {name}`
  String homeTitleUser(Object name) {
    return Intl.message(
      'Hi, $name',
      name: 'homeTitleUser',
      desc: '',
      args: [name],
    );
  }

  /// `Hi, Guest`
  String get homeTitleGuest {
    return Intl.message(
      'Hi, Guest',
      name: 'homeTitleGuest',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get nameGuest {
    return Intl.message(
      'Guest',
      name: 'nameGuest',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get homeTitleExplore {
    return Intl.message(
      'Explore',
      name: 'homeTitleExplore',
      desc: '',
      args: [],
    );
  }

  /// `Popular Categories`
  String get homeTitlePopularCategories {
    return Intl.message(
      'Popular Categories',
      name: 'homeTitlePopularCategories',
      desc: '',
      args: [],
    );
  }

  /// `Recently Viewed`
  String get homeTitleRecentlyViewed {
    return Intl.message(
      'Recently Viewed',
      name: 'homeTitleRecentlyViewed',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated Locations`
  String get homeTitleTopRated {
    return Intl.message(
      'Top Rated Locations',
      name: 'homeTitleTopRated',
      desc: '',
      args: [],
    );
  }

  /// `Start Adding to Cart!`
  String get homeHeaderSubtitle {
    return Intl.message(
      'Start Adding to Cart!',
      name: 'homeHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for a product`
  String get homePlaceholderSearch {
    return Intl.message(
      'Search for a product',
      name: 'homePlaceholderSearch',
      desc: '',
      args: [],
    );
  }

  /// `Open web page?`
  String get locationWebConfirmation {
    return Intl.message(
      'Open web page?',
      name: 'locationWebConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get locationClosed {
    return Intl.message(
      'Closed',
      name: 'locationClosed',
      desc: '',
      args: [],
    );
  }

  /// `Currently closed`
  String get locationCurrentlyClosed {
    return Intl.message(
      'Currently closed',
      name: 'locationCurrentlyClosed',
      desc: '',
      args: [],
    );
  }

  /// `Call number {number}?`
  String locationCallConfirmation(Object number) {
    return Intl.message(
      'Call number $number?',
      name: 'locationCallConfirmation',
      desc: '',
      args: [number],
    );
  }

  /// `Instant confirmation!`
  String get locationInstantConfirmation {
    return Intl.message(
      'Instant confirmation!',
      name: 'locationInstantConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get productButtonAddToCart {
    return Intl.message(
      'Add to cart',
      name: 'productButtonAddToCart',
      desc: '',
      args: [],
    );
  }

  /// `{num} reviews`
  String locationTotalReviews(Object num) {
    return Intl.message(
      '$num reviews',
      name: 'locationTotalReviews',
      desc: '',
      args: [num],
    );
  }

  /// `See all reviews`
  String get locationLinkAllReviews {
    return Intl.message(
      'See all reviews',
      name: 'locationLinkAllReviews',
      desc: '',
      args: [],
    );
  }

  /// `See all services`
  String get locationLinkAllServices {
    return Intl.message(
      'See all services',
      name: 'locationLinkAllServices',
      desc: '',
      args: [],
    );
  }

  /// `Replied on {date}`
  String locationRepliedOn(Object date) {
    return Intl.message(
      'Replied on $date',
      name: 'locationRepliedOn',
      desc: '',
      args: [date],
    );
  }

  /// `No Products found! Check back later!`
  String get locationNoResults {
    return Intl.message(
      'No Products found! Check back later!',
      name: 'locationNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Working hours`
  String get locationLabelWorkingHours {
    return Intl.message(
      'Working hours',
      name: 'locationLabelWorkingHours',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get locationLabelPhone {
    return Intl.message(
      'Phone',
      name: 'locationLabelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Web`
  String get locationLabelWeb {
    return Intl.message(
      'Web',
      name: 'locationLabelWeb',
      desc: '',
      args: [],
    );
  }

  /// `Genders`
  String get locationLabelGenders {
    return Intl.message(
      'Genders',
      name: 'locationLabelGenders',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get locationTitleAboutUs {
    return Intl.message(
      'About Us',
      name: 'locationTitleAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get locationTitleReviews {
    return Intl.message(
      'Reviews',
      name: 'locationTitleReviews',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Locations`
  String get locationTitleNearby {
    return Intl.message(
      'Nearby Locations',
      name: 'locationTitleNearby',
      desc: '',
      args: [],
    );
  }

  /// `Ratings`
  String get locationTitleRatings {
    return Intl.message(
      'Ratings',
      name: 'locationTitleRatings',
      desc: '',
      args: [],
    );
  }

  /// `Top Services`
  String get locationTitleTopServices {
    return Intl.message(
      'Top Services',
      name: 'locationTitleTopServices',
      desc: '',
      args: [],
    );
  }

  /// `Our Staff`
  String get locationTitleStaff {
    return Intl.message(
      'Our Staff',
      name: 'locationTitleStaff',
      desc: '',
      args: [],
    );
  }

  /// `{num} services available`
  String locationAvailableServies(Object num) {
    return Intl.message(
      '$num services available',
      name: 'locationAvailableServies',
      desc: '',
      args: [num],
    );
  }

  /// `{day, select, monday {Monday} tuesday {Tuesday} wednesday {Wednesday} thursday {Thursday} friday {Friday} saturday {Saturday} sunday {Sunday} other {Unknown}}`
  String commonWeekdayLong(Object day) {
    return Intl.select(
      day,
      {
        'monday': 'Monday',
        'tuesday': 'Tuesday',
        'wednesday': 'Wednesday',
        'thursday': 'Thursday',
        'friday': 'Friday',
        'saturday': 'Saturday',
        'sunday': 'Sunday',
        'other': 'Unknown',
      },
      name: 'commonWeekdayLong',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, monday {Mon} tuesday {Tue} wednesday {Wed} thursday {Thu} friday {Fri} saturday {Sat} sunday {Sun} other {Unknown}}`
  String commonWeekdayShort(Object day) {
    return Intl.select(
      day,
      {
        'monday': 'Mon',
        'tuesday': 'Tue',
        'wednesday': 'Wed',
        'thursday': 'Thu',
        'friday': 'Fri',
        'saturday': 'Sat',
        'sunday': 'Sun',
        'other': 'Unknown',
      },
      name: 'commonWeekdayShort',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, january {January} february {February} march {March} april {April} may {May} june {June} july {July} august {August} september {September} october {October} november {November} december {December} other {Unknown}}`
  String commonMonthLong(Object day) {
    return Intl.select(
      day,
      {
        'january': 'January',
        'february': 'February',
        'march': 'March',
        'april': 'April',
        'may': 'May',
        'june': 'June',
        'july': 'July',
        'august': 'August',
        'september': 'September',
        'october': 'October',
        'november': 'November',
        'december': 'December',
        'other': 'Unknown',
      },
      name: 'commonMonthLong',
      desc: '',
      args: [day],
    );
  }

  /// `{day, select, january {Jan} february {Feb} march {Mar} april {Apr} may {May} june {Jun} july {Jul} august {Aug} september {Sep} october {Oct} november {Nov} december {Dec} other {Unknown}}`
  String commonMonthShort(Object day) {
    return Intl.select(
      day,
      {
        'january': 'Jan',
        'february': 'Feb',
        'march': 'Mar',
        'april': 'Apr',
        'may': 'May',
        'june': 'Jun',
        'july': 'Jul',
        'august': 'Aug',
        'september': 'Sep',
        'october': 'Oct',
        'november': 'Nov',
        'december': 'Dec',
        'other': 'Unknown',
      },
      name: 'commonMonthShort',
      desc: '',
      args: [day],
    );
  }

  /// `Today`
  String get commonWeekdayToday {
    return Intl.message(
      'Today',
      name: 'commonWeekdayToday',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get commonWeekdayTomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'commonWeekdayTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get commonSearchSortTypeRating {
    return Intl.message(
      'Top rated',
      name: 'commonSearchSortTypeRating',
      desc: '',
      args: [],
    );
  }

  /// `Most popular`
  String get commonSearchSortTypePopularity {
    return Intl.message(
      'Most popular',
      name: 'commonSearchSortTypePopularity',
      desc: '',
      args: [],
    );
  }

  /// `Price High-Low`
  String get commonSortHTL {
    return Intl.message(
      'Price High-Low',
      name: 'commonSortHTL',
      desc: '',
      args: [],
    );
  }

  /// `Price Low-High`
  String get commonSortLTL {
    return Intl.message(
      'Price Low-High',
      name: 'commonSortLTL',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get commonBtnOk {
    return Intl.message(
      'Ok',
      name: 'commonBtnOk',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get commonBtnCancel {
    return Intl.message(
      'Cancel',
      name: 'commonBtnCancel',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get commonBtnApply {
    return Intl.message(
      'Apply',
      name: 'commonBtnApply',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get commonBtnClose {
    return Intl.message(
      'Close',
      name: 'commonBtnClose',
      desc: '',
      args: [],
    );
  }

  /// `Pull down to refresh`
  String get commonSmartRefresherHeaderIdleText {
    return Intl.message(
      'Pull down to refresh',
      name: 'commonSmartRefresherHeaderIdleText',
      desc: '',
      args: [],
    );
  }

  /// `Refreshing...`
  String get commonSmartRefresherHeaderRefreshingText {
    return Intl.message(
      'Refreshing...',
      name: 'commonSmartRefresherHeaderRefreshingText',
      desc: '',
      args: [],
    );
  }

  /// `Refresh completed`
  String get commonSmartRefresherHeaderCompleteText {
    return Intl.message(
      'Refresh completed',
      name: 'commonSmartRefresherHeaderCompleteText',
      desc: '',
      args: [],
    );
  }

  /// `Release to refresh`
  String get commonSmartRefresherHeaderReleaseText {
    return Intl.message(
      'Release to refresh',
      name: 'commonSmartRefresherHeaderReleaseText',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get commonSmartRefresherFooterLoadingText {
    return Intl.message(
      'Loading...',
      name: 'commonSmartRefresherFooterLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `Release to load more`
  String get commonSmartRefresherFooterCanLoadingText {
    return Intl.message(
      'Release to load more',
      name: 'commonSmartRefresherFooterCanLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `Pull to load more`
  String get commonSmartRefresherFooterIdleText {
    return Intl.message(
      'Pull to load more',
      name: 'commonSmartRefresherFooterIdleText',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get commonDialogsErrorTitle {
    return Intl.message(
      'Oops!',
      name: 'commonDialogsErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `{mode, select, dynamic {Dynamic} alwaysOn {Always on} alwaysOff {Always off} other {Unknown}}`
  String commonDarkMode(Object mode) {
    return Intl.select(
      mode,
      {
        'dynamic': 'Dynamic',
        'alwaysOn': 'Always on',
        'alwaysOff': 'Always off',
        'other': 'Unknown',
      },
      name: 'commonDarkMode',
      desc: '',
      args: [mode],
    );
  }

  /// `{locale, select, en {English} de {Deutch} other {Unknown}}`
  String commonLocales(Object locale) {
    return Intl.select(
      locale,
      {
        'en': 'English',
        'de': 'Deutch',
        'other': 'Unknown',
      },
      name: 'commonLocales',
      desc: '',
      args: [locale],
    );
  }

  /// `{source, select, gallery {Photo gallery} camera {Phone camera}}`
  String commonPhotoSources(Object source) {
    return Intl.select(
      source,
      {
        'gallery': 'Photo gallery',
        'camera': 'Phone camera',
      },
      name: 'commonPhotoSources',
      desc: '',
      args: [source],
    );
  }

  /// `₹ {value}`
  String commonCurrencyFormat(Object value) {
    return Intl.message(
      '₹ $value',
      name: 'commonCurrencyFormat',
      desc: '',
      args: [value],
    );
  }

  /// `{value} min`
  String commonDurationFormat(Object value) {
    return Intl.message(
      '$value min',
      name: 'commonDurationFormat',
      desc: '',
      args: [value],
    );
  }

  /// `{status, select, active {active} canceled {canceled} completed {completed} declined {declined} failed {failed} other {unknown}}`
  String commonAppointmentStatus(Object status) {
    return Intl.select(
      status,
      {
        'active': 'active',
        'canceled': 'canceled',
        'completed': 'completed',
        'declined': 'declined',
        'failed': 'failed',
        'other': 'unknown',
      },
      name: 'commonAppointmentStatus',
      desc: '',
      args: [status],
    );
  }

  /// `in 1 day, {hours} hours`
  String commonElapsedDayHours(Object hours) {
    return Intl.message(
      'in 1 day, $hours hours',
      name: 'commonElapsedDayHours',
      desc: '',
      args: [hours],
    );
  }

  /// `in {days} days`
  String commonElapsedDays(Object days) {
    return Intl.message(
      'in $days days',
      name: 'commonElapsedDays',
      desc: '',
      args: [days],
    );
  }

  /// `in 1 hour, {mins} mins`
  String commonElapseHhourMins(Object mins) {
    return Intl.message(
      'in 1 hour, $mins mins',
      name: 'commonElapseHhourMins',
      desc: '',
      args: [mins],
    );
  }

  /// `in {hours} hours`
  String commonElapsedHours(Object hours) {
    return Intl.message(
      'in $hours hours',
      name: 'commonElapsedHours',
      desc: '',
      args: [hours],
    );
  }

  /// `in {mins} mins`
  String commonElapsedMins(Object mins) {
    return Intl.message(
      'in $mins mins',
      name: 'commonElapsedMins',
      desc: '',
      args: [mins],
    );
  }

  /// `in process`
  String get commonElapsedNow {
    return Intl.message(
      'in process',
      name: 'commonElapsedNow',
      desc: '',
      args: [],
    );
  }

  /// `Location added to your favorites list.`
  String get commonLocationFavorited {
    return Intl.message(
      'Location added to your favorites list.',
      name: 'commonLocationFavorited',
      desc: '',
      args: [],
    );
  }

  /// `Location removed from your favorites list.`
  String get commonLocationUnfavorited {
    return Intl.message(
      'Location removed from your favorites list.',
      name: 'commonLocationUnfavorited',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get commonTooltipInfo {
    return Intl.message(
      'Info',
      name: 'commonTooltipInfo',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get commonTooltipRefresh {
    return Intl.message(
      'Refresh',
      name: 'commonTooltipRefresh',
      desc: '',
      args: [],
    );
  }

  /// `read more`
  String get commonReadMore {
    return Intl.message(
      'read more',
      name: 'commonReadMore',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInTitle {
    return Intl.message(
      'Sign in',
      name: 'signInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to BreakQ`
  String get signInFormTitle {
    return Intl.message(
      'Welcome to BreakQ',
      name: 'signInFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login with your phone number`
  String get signInFormMobileTitle {
    return Intl.message(
      'Login with your phone number',
      name: 'signInFormMobileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get signInButtonLogin {
    return Intl.message(
      'Send OTP',
      name: 'signInButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message(
      'Sign In',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signInButtonRegister {
    return Intl.message(
      'Sign up',
      name: 'signInButtonRegister',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get signInHintPhone {
    return Intl.message(
      'Enter Phone Number',
      name: 'signInHintPhone',
      desc: '',
      args: [],
    );
  }

  /// `An SMS will we sent to you on this number.\nStandard SMS charges apply.`
  String get signInRegisterLabel {
    return Intl.message(
      'An SMS will we sent to you on this number.\nStandard SMS charges apply.',
      name: 'signInRegisterLabel',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get signInOTPTitle {
    return Intl.message(
      'OTP Verification',
      name: 'signInOTPTitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto verifying OTP`
  String get signInOTPAutoVerify {
    return Intl.message(
      'Auto verifying OTP',
      name: 'signInOTPAutoVerify',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP sent to your phone`
  String get signInOTPFormTitle {
    return Intl.message(
      'Enter the OTP sent to your phone',
      name: 'signInOTPFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get signInOTPButtonLogin {
    return Intl.message(
      'Verify OTP',
      name: 'signInOTPButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `Didn't recieve the OTP yet?`
  String get signInOTPResendTitle {
    return Intl.message(
      'Didn\'t recieve the OTP yet?',
      name: 'signInOTPResendTitle',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get signInOTPResend {
    return Intl.message(
      'Resend OTP',
      name: 'signInOTPResend',
      desc: '',
      args: [],
    );
  }

  /// `Yet to be Implemented`
  String get emptyTitle {
    return Intl.message(
      'Yet to be Implemented',
      name: 'emptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Locations ({num})`
  String searchTitleResults(Object num) {
    return Intl.message(
      'Locations ($num)',
      name: 'searchTitleResults',
      desc: '',
      args: [num],
    );
  }

  /// `No results`
  String get searchTitleNoResults {
    return Intl.message(
      'No results',
      name: 'searchTitleNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Location service disabled`
  String get searchTitleLocationServiceDisabled {
    return Intl.message(
      'Location service disabled',
      name: 'searchTitleLocationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Sort order`
  String get searchTitleSortOrder {
    return Intl.message(
      'Sort order',
      name: 'searchTitleSortOrder',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get searchTitleFilter {
    return Intl.message(
      'Filter',
      name: 'searchTitleFilter',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get searchTitleRating {
    return Intl.message(
      'Rating',
      name: 'searchTitleRating',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get searchTitlePriceRange {
    return Intl.message(
      'Price Range',
      name: 'searchTitlePriceRange',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get searchTitlePrice {
    return Intl.message(
      'Price',
      name: 'searchTitlePrice',
      desc: '',
      args: [],
    );
  }

  /// `Recent searches`
  String get searchTitleRecentSearches {
    return Intl.message(
      'Recent searches',
      name: 'searchTitleRecentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get searchTitleCategories {
    return Intl.message(
      'Categories',
      name: 'searchTitleCategories',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get searchLabelAll {
    return Intl.message(
      'All',
      name: 'searchLabelAll',
      desc: '',
      args: [],
    );
  }

  /// `Nearby`
  String get searchLabelNearby {
    return Intl.message(
      'Nearby',
      name: 'searchLabelNearby',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get searchLabelQuickSearch {
    return Intl.message(
      'What are you looking for?',
      name: 'searchLabelQuickSearch',
      desc: '',
      args: [],
    );
  }

  /// `{num}+ Stars`
  String searchLabelRatingFilter(Object num) {
    return Intl.message(
      '$num+ Stars',
      name: 'searchLabelRatingFilter',
      desc: '',
      args: [num],
    );
  }

  /// `Venue name...`
  String get searchPlaceholderQuickSearchLocations {
    return Intl.message(
      'Venue name...',
      name: 'searchPlaceholderQuickSearchLocations',
      desc: '',
      args: [],
    );
  }

  /// `City name...`
  String get searchPlaceholderQuickSearchCities {
    return Intl.message(
      'City name...',
      name: 'searchPlaceholderQuickSearchCities',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get searchTooltipFilters {
    return Intl.message(
      'Filters',
      name: 'searchTooltipFilters',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get searchTooltipView {
    return Intl.message(
      'View',
      name: 'searchTooltipView',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get searchTooltipMap {
    return Intl.message(
      'Map',
      name: 'searchTooltipMap',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get searchTooltipBack {
    return Intl.message(
      'Back',
      name: 'searchTooltipBack',
      desc: '',
      args: [],
    );
  }

  /// `₹ {from} - ₹ {to}`
  String searchDrawerDistanceRange(Object from, Object to) {
    return Intl.message(
      '₹ $from - ₹ $to',
      name: 'searchDrawerDistanceRange',
      desc: '',
      args: [from, to],
    );
  }

  /// `All`
  String get searchBtnGroupAll {
    return Intl.message(
      'All',
      name: 'searchBtnGroupAll',
      desc: '',
      args: [],
    );
  }

  /// `Grocery`
  String get searchBtnGroupGrocery {
    return Intl.message(
      'Grocery',
      name: 'searchBtnGroupGrocery',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get pickerBtnSelect {
    return Intl.message(
      'Select',
      name: 'pickerBtnSelect',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get pickerPlaceholderSearch {
    return Intl.message(
      'Search',
      name: 'pickerPlaceholderSearch',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get pickerTitleCity {
    return Intl.message(
      'Select Location',
      name: 'pickerTitleCity',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get pickerTitleDate {
    return Intl.message(
      'Select Date',
      name: 'pickerTitleDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get pickerTitleLanguages {
    return Intl.message(
      'Select Language',
      name: 'pickerTitleLanguages',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to BreakQ`
  String get onboardingPage1Title {
    return Intl.message(
      'Welcome to BreakQ',
      name: 'onboardingPage1Title',
      desc: '',
      args: [],
    );
  }

  /// `BreakQ is a more convinient way to shop now, with a simple concept of NO MORE QUEUES!`
  String get onboardingPage1Body {
    return Intl.message(
      'BreakQ is a more convinient way to shop now, with a simple concept of NO MORE QUEUES!',
      name: 'onboardingPage1Body',
      desc: '',
      args: [],
    );
  }

  /// `Scan Barcode`
  String get onboardingPage2Title {
    return Intl.message(
      'Scan Barcode',
      name: 'onboardingPage2Title',
      desc: '',
      args: [],
    );
  }

  /// `Just scan the barcodes in the store to add the items in your cart for a fast checkout`
  String get onboardingPage2Body {
    return Intl.message(
      'Just scan the barcodes in the store to add the items in your cart for a fast checkout',
      name: 'onboardingPage2Body',
      desc: '',
      args: [],
    );
  }

  /// `Checkout with QR code`
  String get onboardingPage3Title {
    return Intl.message(
      'Checkout with QR code',
      name: 'onboardingPage3Title',
      desc: '',
      args: [],
    );
  }

  /// `Just show the QR code at checkout. No more waiting in line.`
  String get onboardingPage3Body {
    return Intl.message(
      'Just show the QR code at checkout. No more waiting in line.',
      name: 'onboardingPage3Body',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get onboardingBtnSkip {
    return Intl.message(
      'Skip',
      name: 'onboardingBtnSkip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboardingBtnGetStarted {
    return Intl.message(
      'Get Started',
      name: 'onboardingBtnGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Email format invalid`
  String get formValidatorEmail {
    return Intl.message(
      'Email format invalid',
      name: 'formValidatorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Min. length is {length} characters`
  String formValidatorMinLength(Object length) {
    return Intl.message(
      'Min. length is $length characters',
      name: 'formValidatorMinLength',
      desc: '',
      args: [length],
    );
  }

  /// `Please enter your Name`
  String get formValidatorNameRequired {
    return Intl.message(
      'Please enter your Name',
      name: 'formValidatorNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Phone Number`
  String get formValidatorPhoneRequired {
    return Intl.message(
      'Please enter your Phone Number',
      name: 'formValidatorPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password format invalid`
  String get formValidatorInvalidPassword {
    return Intl.message(
      'Password format invalid',
      name: 'formValidatorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered email address and we shall send you a secure link to reset your password.`
  String get forgotPasswordLabel {
    return Intl.message(
      'Enter your registered email address and we shall send you a secure link to reset your password.',
      name: 'forgotPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get forgotPasswordBtn {
    return Intl.message(
      'Reset Password',
      name: 'forgotPasswordBtn',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get forgotPasswordBack {
    return Intl.message(
      'Back to login',
      name: 'forgotPasswordBack',
      desc: '',
      args: [],
    );
  }

  /// `Secure link has been sent`
  String get forgotPasswordDialogTitle {
    return Intl.message(
      'Secure link has been sent',
      name: 'forgotPasswordDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Secure link to reset your password has been sent to the provided email address.`
  String get forgotPasswordDialogText {
    return Intl.message(
      'Secure link to reset your password has been sent to the provided email address.',
      name: 'forgotPasswordDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get signUpTitle {
    return Intl.message(
      'Create an account',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {length} characters long and contain at least one number and one uppercase letter.`
  String signUpHelptextPassword(Object length) {
    return Intl.message(
      'Password must be at least $length characters long and contain at least one number and one uppercase letter.',
      name: 'signUpHelptextPassword',
      desc: '',
      args: [length],
    );
  }

  /// `I have read and agree with the User Terms of Service and I understand that my personal data will be processed in accordance with Privacy Statement.`
  String get signUpLabelConsent {
    return Intl.message(
      'I have read and agree with the User Terms of Service and I understand that my personal data will be processed in accordance with Privacy Statement.',
      name: 'signUpLabelConsent',
      desc: '',
      args: [],
    );
  }

  /// `View the legal documents`
  String get signUpReadMore {
    return Intl.message(
      'View the legal documents',
      name: 'signUpReadMore',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpBtnSend {
    return Intl.message(
      'Sign up',
      name: 'signUpBtnSend',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get signUpLabelFullName {
    return Intl.message(
      'Full name',
      name: 'signUpLabelFullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get signUpLabelPhone {
    return Intl.message(
      'Phone Number',
      name: 'signUpLabelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your full name`
  String get signUpHintFullName {
    return Intl.message(
      'Your full name',
      name: 'signUpHintFullName',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the Terms and Conditions of Service to continue.`
  String get signUpErrorConsent {
    return Intl.message(
      'You must accept the Terms and Conditions of Service to continue.',
      name: 'signUpErrorConsent',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign In`
  String get signUpAlreadyHaveAccount {
    return Intl.message(
      'Already have an account? Sign In',
      name: 'signUpAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign Up`
  String get signInDontHaveAccount {
    return Intl.message(
      'Don\'t have an account? Sign Up',
      name: 'signInDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `My appointments`
  String get profileListAppointments {
    return Intl.message(
      'My appointments',
      name: 'profileListAppointments',
      desc: '',
      args: [],
    );
  }

  /// `My vouchers`
  String get profileListVouchers {
    return Intl.message(
      'My vouchers',
      name: 'profileListVouchers',
      desc: '',
      args: [],
    );
  }

  /// `My favorites`
  String get profileListFavorites {
    return Intl.message(
      'My favorites',
      name: 'profileListFavorites',
      desc: '',
      args: [],
    );
  }

  /// `My reviews`
  String get profileListReviews {
    return Intl.message(
      'My reviews',
      name: 'profileListReviews',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get profileListEdit {
    return Intl.message(
      'Edit profile',
      name: 'profileListEdit',
      desc: '',
      args: [],
    );
  }

  /// `More settings`
  String get profileListSettings {
    return Intl.message(
      'More settings',
      name: 'profileListSettings',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profileListLogout {
    return Intl.message(
      'Logout',
      name: 'profileListLogout',
      desc: '',
      args: [],
    );
  }

  /// `Payment card`
  String get profileListPaymentCard {
    return Intl.message(
      'Payment card',
      name: 'profileListPaymentCard',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends`
  String get profileListInvite {
    return Intl.message(
      'Invite friends',
      name: 'profileListInvite',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categoriesTitle {
    return Intl.message(
      'Categories',
      name: 'categoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profileListTitleSettings {
    return Intl.message(
      'Settings',
      name: 'profileListTitleSettings',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orderTitle {
    return Intl.message(
      'Orders',
      name: 'orderTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get orderListMyOrders {
    return Intl.message(
      'My Orders',
      name: 'orderListMyOrders',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get orderListMyCart {
    return Intl.message(
      'My Cart',
      name: 'orderListMyCart',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsListLanguage {
    return Intl.message(
      'Language',
      name: 'settingsListLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get settingsListDarkMode {
    return Intl.message(
      'Dark mode',
      name: 'settingsListDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Terms of usage`
  String get settingsListTerms {
    return Intl.message(
      'Terms of usage',
      name: 'settingsListTerms',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get settingsListPrivacy {
    return Intl.message(
      'Privacy policy',
      name: 'settingsListPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `© 2020 MTS BreakQ`
  String get settingsCopyright {
    return Intl.message(
      '© 2020 MTS BreakQ',
      name: 'settingsCopyright',
      desc: '',
      args: [],
    );
  }

  /// `Want to visit the template homepage?`
  String get settingsHomepageConfirmation {
    return Intl.message(
      'Want to visit the template homepage?',
      name: 'settingsHomepageConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get settingsListTitleMobile {
    return Intl.message(
      'Mobile No.',
      name: 'settingsListTitleMobile',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get settingsListTitleSupport {
    return Intl.message(
      'Support',
      name: 'settingsListTitleSupport',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfileTitle {
    return Intl.message(
      'Edit Profile',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get editProfileListTitleContact {
    return Intl.message(
      'Contact',
      name: 'editProfileListTitleContact',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get editProfileListTitleAddress {
    return Intl.message(
      'Address',
      name: 'editProfileListTitleAddress',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get editProfileLabelFullname {
    return Intl.message(
      'Full name',
      name: 'editProfileLabelFullname',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get editProfileLabelPhone {
    return Intl.message(
      'Phone number',
      name: 'editProfileLabelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get editProfileLabelAddress {
    return Intl.message(
      'Address',
      name: 'editProfileLabelAddress',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get editProfileLabelCity {
    return Intl.message(
      'City',
      name: 'editProfileLabelCity',
      desc: '',
      args: [],
    );
  }

  /// `ZIP`
  String get editProfileLabelZIP {
    return Intl.message(
      'ZIP',
      name: 'editProfileLabelZIP',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get editProfileBtnUpdate {
    return Intl.message(
      'Update profile',
      name: 'editProfileBtnUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully.`
  String get editProfileSuccess {
    return Intl.message(
      'Profile updated successfully.',
      name: 'editProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointmentsTitle {
    return Intl.message(
      'Appointments',
      name: 'appointmentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No upcoming appointments found.`
  String get appointmentsWarningUpcomingList {
    return Intl.message(
      'No upcoming appointments found.',
      name: 'appointmentsWarningUpcomingList',
      desc: '',
      args: [],
    );
  }

  /// `No previous appointments found.`
  String get appointmentsWarningCompletedList {
    return Intl.message(
      'No previous appointments found.',
      name: 'appointmentsWarningCompletedList',
      desc: '',
      args: [],
    );
  }

  /// `No appointment found that matches your search criteria.`
  String get appointmentsWarningOtherList {
    return Intl.message(
      'No appointment found that matches your search criteria.',
      name: 'appointmentsWarningOtherList',
      desc: '',
      args: [],
    );
  }

  /// `Explore salons nearby`
  String get appointmentsBtnExplore {
    return Intl.message(
      'Explore salons nearby',
      name: 'appointmentsBtnExplore',
      desc: '',
      args: [],
    );
  }

  /// `{status, select, active {Active} completed {Completed} other {Other}}`
  String appointmentsStatusGroup(Object status) {
    return Intl.select(
      status,
      {
        'active': 'Active',
        'completed': 'Completed',
        'other': 'Other',
      },
      name: 'appointmentsStatusGroup',
      desc: '',
      args: [status],
    );
  }

  /// `{sort, select, date_asc {Oldest first} date_desc {Newest first} other {Other}}`
  String appointmentsSort(Object sort) {
    return Intl.select(
      sort,
      {
        'date_asc': 'Oldest first',
        'date_desc': 'Newest first',
        'other': 'Other',
      },
      name: 'appointmentsSort',
      desc: '',
      args: [sort],
    );
  }

  /// `My Appointments`
  String get appointmentsWelcomeTitle {
    return Intl.message(
      'My Appointments',
      name: 'appointmentsWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore and book your first appointment`
  String get appointmentsWelcomeSubtitle {
    return Intl.message(
      'Explore and book your first appointment',
      name: 'appointmentsWelcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Already registered?`
  String get appointmentsWelcomeSignInLabel {
    return Intl.message(
      'Already registered?',
      name: 'appointmentsWelcomeSignInLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get appointmentsWelcomeSignInBtn {
    return Intl.message(
      'Sign in',
      name: 'appointmentsWelcomeSignInBtn',
      desc: '',
      args: [],
    );
  }

  /// `My favorites`
  String get favoritesTitle {
    return Intl.message(
      'My favorites',
      name: 'favoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No favorites yet`
  String get favoritesTitleNoResults {
    return Intl.message(
      'No favorites yet',
      name: 'favoritesTitleNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Your favorites list is empty.`
  String get favoritesNoResults {
    return Intl.message(
      'Your favorites list is empty.',
      name: 'favoritesNoResults',
      desc: '',
      args: [],
    );
  }

  /// `My vouchers`
  String get vouchersTitle {
    return Intl.message(
      'My vouchers',
      name: 'vouchersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get vouchersTabActive {
    return Intl.message(
      'Active',
      name: 'vouchersTabActive',
      desc: '',
      args: [],
    );
  }

  /// `Redeemed`
  String get vouchersTabRedeemed {
    return Intl.message(
      'Redeemed',
      name: 'vouchersTabRedeemed',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get vouchersTabExpired {
    return Intl.message(
      'Expired',
      name: 'vouchersTabExpired',
      desc: '',
      args: [],
    );
  }

  /// `Valid until: {date}`
  String vouchersDueDateActive(Object date) {
    return Intl.message(
      'Valid until: $date',
      name: 'vouchersDueDateActive',
      desc: '',
      args: [date],
    );
  }

  /// `Expired on: {date}`
  String vouchersDueDateExpired(Object date) {
    return Intl.message(
      'Expired on: $date',
      name: 'vouchersDueDateExpired',
      desc: '',
      args: [date],
    );
  }

  /// `Redeemed on: {date}`
  String vouchersDueDateRedeemed(Object date) {
    return Intl.message(
      'Redeemed on: $date',
      name: 'vouchersDueDateRedeemed',
      desc: '',
      args: [date],
    );
  }

  /// `Here you can see a list of your coupons that you can use the next time you visit a particular location. When paying the bill for a certain service, the final amount will be reduced by the amount indicated on the coupon.`
  String get vouchersInfo {
    return Intl.message(
      'Here you can see a list of your coupons that you can use the next time you visit a particular location. When paying the bill for a certain service, the final amount will be reduced by the amount indicated on the coupon.',
      name: 'vouchersInfo',
      desc: '',
      args: [],
    );
  }

  /// `No available coupon found.`
  String get vouchersHeroNoteActive {
    return Intl.message(
      'No available coupon found.',
      name: 'vouchersHeroNoteActive',
      desc: '',
      args: [],
    );
  }

  /// `No coupon expired so far.`
  String get vouchersHeroNoteExpired {
    return Intl.message(
      'No coupon expired so far.',
      name: 'vouchersHeroNoteExpired',
      desc: '',
      args: [],
    );
  }

  /// `You have not used any of your coupons so far.`
  String get vouchersHeroNoteRedeemed {
    return Intl.message(
      'You have not used any of your coupons so far.',
      name: 'vouchersHeroNoteRedeemed',
      desc: '',
      args: [],
    );
  }

  /// `off the final price`
  String get vouchersLabelOff {
    return Intl.message(
      'off the final price',
      name: 'vouchersLabelOff',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get voucherLabelCouponCode {
    return Intl.message(
      'Coupon Code',
      name: 'voucherLabelCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Special Terms And Conditions`
  String get voucherLabelSpecialTerms {
    return Intl.message(
      'Special Terms And Conditions',
      name: 'voucherLabelSpecialTerms',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get QSBtnFinish {
    return Intl.message(
      'Add to Cart',
      name: 'QSBtnFinish',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get QSBtnNext {
    return Intl.message(
      'Next',
      name: 'QSBtnNext',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get QSBtnCancel {
    return Intl.message(
      'Cancel',
      name: 'QSBtnCancel',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one bill`
  String get QSWarningBills {
    return Intl.message(
      'Please select at least one bill',
      name: 'QSWarningBills',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one product`
  String get QSWarningProducts {
    return Intl.message(
      'Please select at least one product',
      name: 'QSWarningProducts',
      desc: '',
      args: [],
    );
  }

  /// `No bills to show`
  String get QSWarningNoBills {
    return Intl.message(
      'No bills to show',
      name: 'QSWarningNoBills',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get QSBtnClose {
    return Intl.message(
      'Ok',
      name: 'QSBtnClose',
      desc: '',
      args: [],
    );
  }

  /// `Step {current} of {total}`
  String bookingLabelSteps(Object current, Object total) {
    return Intl.message(
      'Step $current of $total',
      name: 'bookingLabelSteps',
      desc: '',
      args: [current, total],
    );
  }

  /// `{page, select, page1 {Select Bills} page2 {Select Products}}`
  String bookingTitleWizardPage(Object page) {
    return Intl.select(
      page,
      {
        'page1': 'Select Bills',
        'page2': 'Select Products',
      },
      name: 'bookingTitleWizardPage',
      desc: '',
      args: [page],
    );
  }

  /// `Verify Details and Place Order`
  String get bookingSubtitleLocation {
    return Intl.message(
      'Verify Details and Place Order',
      name: 'bookingSubtitleLocation',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get bookingSubtitleAppointment {
    return Intl.message(
      'Appointment',
      name: 'bookingSubtitleAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get bookingSubtitleServices {
    return Intl.message(
      'Services',
      name: 'bookingSubtitleServices',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get bookingSubtitleCheckout {
    return Intl.message(
      'Checkout',
      name: 'bookingSubtitleCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Added!`
  String get QSSuccessTitle {
    return Intl.message(
      'Added!',
      name: 'QSSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `The products were added to the Cart`
  String get QSSuccessSubtitle {
    return Intl.message(
      'The products were added to the Cart',
      name: 'QSSuccessSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Call number {number}?`
  String bookingCallConfirmation(Object number) {
    return Intl.message(
      'Call number $number?',
      name: 'bookingCallConfirmation',
      desc: '',
      args: [number],
    );
  }

  /// `Add booking notes`
  String get bookingAddNotes {
    return Intl.message(
      'Add booking notes',
      name: 'bookingAddNotes',
      desc: '',
      args: [],
    );
  }

  /// `{num} characters remaining`
  String reviewLengthLimit(Object num) {
    return Intl.message(
      '$num characters remaining',
      name: 'reviewLengthLimit',
      desc: '',
      args: [num],
    );
  }

  /// `Please rate this salon by clicking on the number of stars you want to assign.`
  String get reviewWarning {
    return Intl.message(
      'Please rate this salon by clicking on the number of stars you want to assign.',
      name: 'reviewWarning',
      desc: '',
      args: [],
    );
  }

  /// `What's Your Rate?`
  String get reviewLabelRate {
    return Intl.message(
      'What\'s Your Rate?',
      name: 'reviewLabelRate',
      desc: '',
      args: [],
    );
  }

  /// `Your Comment (optional)`
  String get reviewLabelComment {
    return Intl.message(
      'Your Comment (optional)',
      name: 'reviewLabelComment',
      desc: '',
      args: [],
    );
  }

  /// `Rate Your Experience`
  String get reviewTitle {
    return Intl.message(
      'Rate Your Experience',
      name: 'reviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write your review here...`
  String get reviewCommentPlaceholder {
    return Intl.message(
      'Write your review here...',
      name: 'reviewCommentPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get reviewSubmitBtn {
    return Intl.message(
      'Submit Review',
      name: 'reviewSubmitBtn',
      desc: '',
      args: [],
    );
  }

  /// `Thank you`
  String get reviewSuccessTitle {
    return Intl.message(
      'Thank you',
      name: 'reviewSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback has been received and will appear immediately.`
  String get reviewSuccessSubtitle {
    return Intl.message(
      'Your feedback has been received and will appear immediately.',
      name: 'reviewSuccessSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `My Reviews`
  String get reviewsTitle {
    return Intl.message(
      'My Reviews',
      name: 'reviewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Take a picture`
  String get takePictureTitle {
    return Intl.message(
      'Take a picture',
      name: 'takePictureTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment card`
  String get paymentCardTitle {
    return Intl.message(
      'Payment card',
      name: 'paymentCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `No card available`
  String get paymentCardWarningTitle {
    return Intl.message(
      'No card available',
      name: 'paymentCardWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can use your debit or credit card to book an appointment (card will not be charged until all the booked services are complete).`
  String get paymentCardWarningNote {
    return Intl.message(
      'You can use your debit or credit card to book an appointment (card will not be charged until all the booked services are complete).',
      name: 'paymentCardWarningNote',
      desc: '',
      args: [],
    );
  }

  /// `+ Add your card`
  String get paymentCardWarningBtn {
    return Intl.message(
      '+ Add your card',
      name: 'paymentCardWarningBtn',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get addPaymentCardTitle {
    return Intl.message(
      'Add card',
      name: 'addPaymentCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save Card`
  String get addPaymentCardButton {
    return Intl.message(
      'Save Card',
      name: 'addPaymentCardButton',
      desc: '',
      args: [],
    );
  }

  /// `MM/YY`
  String get paymentCardWidgetExpirationDatePlaceholder {
    return Intl.message(
      'MM/YY',
      name: 'paymentCardWidgetExpirationDatePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get paymentCardWidgetExpirationDateLabel {
    return Intl.message(
      'Expiration date',
      name: 'paymentCardWidgetExpirationDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get paymentCardWidgetCardNumberLabel {
    return Intl.message(
      'Card number',
      name: 'paymentCardWidgetCardNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Security code`
  String get paymentCardWidgetSecurityCodeLabel {
    return Intl.message(
      'Security code',
      name: 'paymentCardWidgetSecurityCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Card holder name`
  String get paymentCardWidgetCardHolderLabel {
    return Intl.message(
      'Card holder name',
      name: 'paymentCardWidgetCardHolderLabel',
      desc: '',
      args: [],
    );
  }

  /// `VALID THRU`
  String get paymentCardWidgetValidityLabel {
    return Intl.message(
      'VALID THRU',
      name: 'paymentCardWidgetValidityLabel',
      desc: '',
      args: [],
    );
  }

  /// `CARD HOLDER`
  String get paymentCardWidgetCardHolderPlaceholder {
    return Intl.message(
      'CARD HOLDER',
      name: 'paymentCardWidgetCardHolderPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends`
  String get inviteTitle {
    return Intl.message(
      'Invite friends',
      name: 'inviteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Salon and use code {code} to get US$5 off your first booking expenses.`
  String inviteShareText(Object code) {
    return Intl.message(
      'Get Salon and use code $code to get US\$5 off your first booking expenses.',
      name: 'inviteShareText',
      desc: '',
      args: [code],
    );
  }

  /// `Get discounts by inviting friends`
  String get inviteSubtitle {
    return Intl.message(
      'Get discounts by inviting friends',
      name: 'inviteSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Share your code`
  String get inviteButton {
    return Intl.message(
      'Share your code',
      name: 'inviteButton',
      desc: '',
      args: [],
    );
  }

  /// `Total Earnings`
  String get inviteEarningsLabel {
    return Intl.message(
      'Total Earnings',
      name: 'inviteEarningsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Invite your friends and give them each US$5 in coupons. And for every friend who completes their first booking process, we will give you a US$5 coupon!`
  String get inviteDescription {
    return Intl.message(
      'Invite your friends and give them each US\$5 in coupons. And for every friend who completes their first booking process, we will give you a US\$5 coupon!',
      name: 'inviteDescription',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get inboxTitle {
    return Intl.message(
      'Messages',
      name: 'inboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get inboxSlideButtonArchive {
    return Intl.message(
      'Archive',
      name: 'inboxSlideButtonArchive',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get inboxSlideButtonDelete {
    return Intl.message(
      'Delete',
      name: 'inboxSlideButtonDelete',
      desc: '',
      args: [],
    );
  }

  /// `Type a message...`
  String get chatPlaceholder {
    return Intl.message(
      'Type a message...',
      name: 'chatPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get chatOnlineLabel {
    return Intl.message(
      'Online',
      name: 'chatOnlineLabel',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get walletTitle {
    return Intl.message(
      'Wallet',
      name: 'walletTitle',
      desc: '',
      args: [],
    );
  }

  /// `₹ 0.00`
  String get walletBalance {
    return Intl.message(
      '₹ 0.00',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}