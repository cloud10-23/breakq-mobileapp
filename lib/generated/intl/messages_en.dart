// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(current, total) => "Step ${current} of ${total}";

  static m1(page) => "${Intl.select(page, {'page1': 'Select Bills', 'page2': 'Select Products', })}";

  static m2(status) => "${Intl.select(status, {'active': 'active', 'canceled': 'canceled', 'completed': 'completed', 'declined': 'declined', 'failed': 'failed', 'other': 'unknown', })}";

  static m3(value) => "₹ ${value}";

  static m4(mode) => "${Intl.select(mode, {'dynamic': 'Dynamic', 'alwaysOn': 'Always on', 'alwaysOff': 'Always off', 'other': 'Unknown', })}";

  static m5(value) => "${value} min";

  static m6(mins) => "in 1 hour, ${mins} mins";

  static m7(hours) => "in 1 day, ${hours} hours";

  static m8(days) => "in ${days} days";

  static m9(hours) => "in ${hours} hours";

  static m10(mins) => "in ${mins} mins";

  static m11(locale) => "${Intl.select(locale, {'en': 'English', 'de': 'Deutch', 'other': 'Unknown', })}";

  static m12(day) => "${Intl.select(day, {'january': 'January', 'february': 'February', 'march': 'March', 'april': 'April', 'may': 'May', 'june': 'June', 'july': 'July', 'august': 'August', 'september': 'September', 'october': 'October', 'november': 'November', 'december': 'December', 'other': 'Unknown', })}";

  static m13(day) => "${Intl.select(day, {'january': 'Jan', 'february': 'Feb', 'march': 'Mar', 'april': 'Apr', 'may': 'May', 'june': 'Jun', 'july': 'Jul', 'august': 'Aug', 'september': 'Sep', 'october': 'Oct', 'november': 'Nov', 'december': 'Dec', 'other': 'Unknown', })}";

  static m14(source) => "${Intl.select(source, {'gallery': 'Photo gallery', 'camera': 'Phone camera', })}";

  static m15(day) => "${Intl.select(day, {'monday': 'Monday', 'tuesday': 'Tuesday', 'wednesday': 'Wednesday', 'thursday': 'Thursday', 'friday': 'Friday', 'saturday': 'Saturday', 'sunday': 'Sunday', 'other': 'Unknown', })}";

  static m16(day) => "${Intl.select(day, {'monday': 'Mon', 'tuesday': 'Tue', 'wednesday': 'Wed', 'thursday': 'Thu', 'friday': 'Fri', 'saturday': 'Sat', 'sunday': 'Sun', 'other': 'Unknown', })}";

  static m17(length) => "Min. length is ${length} characters";

  static m18(name) => "Hi, ${name}";

  static m19(from, to) => "₹ ${from} - ₹ ${to}";

  static m20(num) => "${num}+ Stars";

  static m21(num) => "Locations (${num})";

  static m22(length) => "Password must be at least ${length} characters long and contain at least one number and one uppercase letter.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "QSBtnCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "QSBtnClose" : MessageLookupByLibrary.simpleMessage("Ok"),
    "QSBtnFinish" : MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "QSBtnNext" : MessageLookupByLibrary.simpleMessage("Next"),
    "QSSuccessSubtitle" : MessageLookupByLibrary.simpleMessage("The products were added to the Cart"),
    "QSSuccessTitle" : MessageLookupByLibrary.simpleMessage("Added!"),
    "QSWarningBills" : MessageLookupByLibrary.simpleMessage("Please select at least one bill"),
    "QSWarningNoBills" : MessageLookupByLibrary.simpleMessage("No bills to show"),
    "QSWarningProducts" : MessageLookupByLibrary.simpleMessage("Please select at least one product"),
    "bookingLabelSteps" : m0,
    "bookingSubtitleCheckout" : MessageLookupByLibrary.simpleMessage("Checkout"),
    "bookingTitleWizardPage" : m1,
    "categoriesTitle" : MessageLookupByLibrary.simpleMessage("Categories"),
    "commonAppointmentStatus" : m2,
    "commonBtnApply" : MessageLookupByLibrary.simpleMessage("Apply"),
    "commonBtnCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonBtnClose" : MessageLookupByLibrary.simpleMessage("Close"),
    "commonBtnOk" : MessageLookupByLibrary.simpleMessage("Ok"),
    "commonCurrencyFormat" : m3,
    "commonDarkMode" : m4,
    "commonDialogsErrorTitle" : MessageLookupByLibrary.simpleMessage("Oops!"),
    "commonDurationFormat" : m5,
    "commonElapseHhourMins" : m6,
    "commonElapsedDayHours" : m7,
    "commonElapsedDays" : m8,
    "commonElapsedHours" : m9,
    "commonElapsedMins" : m10,
    "commonElapsedNow" : MessageLookupByLibrary.simpleMessage("in process"),
    "commonLocales" : m11,
    "commonLocationFavorited" : MessageLookupByLibrary.simpleMessage("Location added to your favorites list."),
    "commonLocationUnfavorited" : MessageLookupByLibrary.simpleMessage("Location removed from your favorites list."),
    "commonMonthLong" : m12,
    "commonMonthShort" : m13,
    "commonPhotoSources" : m14,
    "commonReadMore" : MessageLookupByLibrary.simpleMessage("read more"),
    "commonSearchSortTypePopularity" : MessageLookupByLibrary.simpleMessage("Most popular"),
    "commonSearchSortTypeRating" : MessageLookupByLibrary.simpleMessage("Top rated"),
    "commonSmartRefresherFooterCanLoadingText" : MessageLookupByLibrary.simpleMessage("Release to load more"),
    "commonSmartRefresherFooterIdleText" : MessageLookupByLibrary.simpleMessage("Pull to load more"),
    "commonSmartRefresherFooterLoadingText" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "commonSmartRefresherHeaderCompleteText" : MessageLookupByLibrary.simpleMessage("Refresh completed"),
    "commonSmartRefresherHeaderIdleText" : MessageLookupByLibrary.simpleMessage("Pull down to refresh"),
    "commonSmartRefresherHeaderRefreshingText" : MessageLookupByLibrary.simpleMessage("Refreshing..."),
    "commonSmartRefresherHeaderReleaseText" : MessageLookupByLibrary.simpleMessage("Release to refresh"),
    "commonSortHTL" : MessageLookupByLibrary.simpleMessage("Price:  High-Low"),
    "commonSortLTL" : MessageLookupByLibrary.simpleMessage("Price:  Low-High"),
    "commonTooltipInfo" : MessageLookupByLibrary.simpleMessage("Info"),
    "commonTooltipRefresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "commonWeekdayLong" : m15,
    "commonWeekdayShort" : m16,
    "commonWeekdayToday" : MessageLookupByLibrary.simpleMessage("Today"),
    "commonWeekdayTomorrow" : MessageLookupByLibrary.simpleMessage("Tomorrow"),
    "editProfileBtnUpdate" : MessageLookupByLibrary.simpleMessage("Update profile"),
    "editProfileLabelAddress" : MessageLookupByLibrary.simpleMessage("Address"),
    "editProfileLabelCity" : MessageLookupByLibrary.simpleMessage("City"),
    "editProfileLabelFullname" : MessageLookupByLibrary.simpleMessage("Full name"),
    "editProfileLabelPhone" : MessageLookupByLibrary.simpleMessage("Phone number"),
    "editProfileLabelZIP" : MessageLookupByLibrary.simpleMessage("ZIP"),
    "editProfileListTitleAddress" : MessageLookupByLibrary.simpleMessage("Address"),
    "editProfileListTitleContact" : MessageLookupByLibrary.simpleMessage("Contact"),
    "editProfileSuccess" : MessageLookupByLibrary.simpleMessage("Profile updated successfully."),
    "editProfileTitle" : MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "emptyTitle" : MessageLookupByLibrary.simpleMessage("Yet to be Implemented"),
    "forgotPasswordBack" : MessageLookupByLibrary.simpleMessage("Back to login"),
    "forgotPasswordBtn" : MessageLookupByLibrary.simpleMessage("Reset Password"),
    "forgotPasswordDialogText" : MessageLookupByLibrary.simpleMessage("Secure link to reset your password has been sent to the provided email address."),
    "forgotPasswordDialogTitle" : MessageLookupByLibrary.simpleMessage("Secure link has been sent"),
    "forgotPasswordLabel" : MessageLookupByLibrary.simpleMessage("Enter your registered email address and we shall send you a secure link to reset your password."),
    "forgotPasswordTitle" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "formValidatorEmail" : MessageLookupByLibrary.simpleMessage("Email format invalid"),
    "formValidatorInvalidPassword" : MessageLookupByLibrary.simpleMessage("Password format invalid"),
    "formValidatorMinLength" : m17,
    "formValidatorNameRequired" : MessageLookupByLibrary.simpleMessage("Please enter your Name"),
    "formValidatorPhoneRequired" : MessageLookupByLibrary.simpleMessage("Please enter your Phone Number"),
    "homeHeaderSubtitle" : MessageLookupByLibrary.simpleMessage("Start Adding to Cart!"),
    "homePlaceholderSearch" : MessageLookupByLibrary.simpleMessage("Search for a product"),
    "homeTitleExplore" : MessageLookupByLibrary.simpleMessage("Explore"),
    "homeTitleGuest" : MessageLookupByLibrary.simpleMessage("Hi, Guest"),
    "homeTitleHi" : MessageLookupByLibrary.simpleMessage("Hi, "),
    "homeTitlePopularCategories" : MessageLookupByLibrary.simpleMessage("Popular Categories"),
    "homeTitleRecentlyViewed" : MessageLookupByLibrary.simpleMessage("Recently Viewed"),
    "homeTitleTopRated" : MessageLookupByLibrary.simpleMessage("Top Rated Locations"),
    "homeTitleUser" : m18,
    "nameGuest" : MessageLookupByLibrary.simpleMessage("Guest"),
    "onboardingBtnGetStarted" : MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingBtnSkip" : MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingPage1Body" : MessageLookupByLibrary.simpleMessage("BreakQ is a more convinient way to shop now, with a simple concept of NO MORE QUEUES!"),
    "onboardingPage1Title" : MessageLookupByLibrary.simpleMessage("Welcome to BreakQ"),
    "onboardingPage2Body" : MessageLookupByLibrary.simpleMessage("Just scan the barcodes in the store to add the items in your cart for a fast checkout"),
    "onboardingPage2Title" : MessageLookupByLibrary.simpleMessage("Scan Barcode"),
    "onboardingPage3Body" : MessageLookupByLibrary.simpleMessage("Just show the QR code at checkout. No more waiting in line."),
    "onboardingPage3Title" : MessageLookupByLibrary.simpleMessage("Checkout with QR code"),
    "orderListMyCart" : MessageLookupByLibrary.simpleMessage("My Cart"),
    "orderListMyOrders" : MessageLookupByLibrary.simpleMessage("My Orders"),
    "orderTitle" : MessageLookupByLibrary.simpleMessage("Orders"),
    "pickerBtnSelect" : MessageLookupByLibrary.simpleMessage("Select"),
    "pickerPlaceholderSearch" : MessageLookupByLibrary.simpleMessage("Search"),
    "pickerTitleCity" : MessageLookupByLibrary.simpleMessage("Select Location"),
    "pickerTitleDate" : MessageLookupByLibrary.simpleMessage("Select Date"),
    "pickerTitleLanguages" : MessageLookupByLibrary.simpleMessage("Select Language"),
    "productButtonAddToCart" : MessageLookupByLibrary.simpleMessage("Add to cart"),
    "productNoResults" : MessageLookupByLibrary.simpleMessage("No Products found! Check back later!"),
    "profileListEdit" : MessageLookupByLibrary.simpleMessage("Edit profile"),
    "profileListLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "profileListTitleSettings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "searchBtnGroupAll" : MessageLookupByLibrary.simpleMessage("All"),
    "searchBtnGroupGrocery" : MessageLookupByLibrary.simpleMessage("Grocery"),
    "searchDrawerDistanceRange" : m19,
    "searchLabelAll" : MessageLookupByLibrary.simpleMessage("All"),
    "searchLabelNearby" : MessageLookupByLibrary.simpleMessage("Nearby"),
    "searchLabelQuickSearch" : MessageLookupByLibrary.simpleMessage("What are you looking for?"),
    "searchLabelRatingFilter" : m20,
    "searchPlaceholderQuickSearchCities" : MessageLookupByLibrary.simpleMessage("City name..."),
    "searchPlaceholderQuickSearchLocations" : MessageLookupByLibrary.simpleMessage("Venue name..."),
    "searchTitleCategories" : MessageLookupByLibrary.simpleMessage("Categories"),
    "searchTitleFilter" : MessageLookupByLibrary.simpleMessage("Filter"),
    "searchTitleLocationServiceDisabled" : MessageLookupByLibrary.simpleMessage("Location service disabled"),
    "searchTitleNoResults" : MessageLookupByLibrary.simpleMessage("No results"),
    "searchTitlePrice" : MessageLookupByLibrary.simpleMessage("Price"),
    "searchTitlePriceRange" : MessageLookupByLibrary.simpleMessage("Price Range"),
    "searchTitleRating" : MessageLookupByLibrary.simpleMessage("Rating"),
    "searchTitleRecentSearches" : MessageLookupByLibrary.simpleMessage("Recent searches"),
    "searchTitleResults" : m21,
    "searchTitleSortOrder" : MessageLookupByLibrary.simpleMessage("Sort order"),
    "searchTooltipBack" : MessageLookupByLibrary.simpleMessage("Back"),
    "searchTooltipFilters" : MessageLookupByLibrary.simpleMessage("Filters"),
    "searchTooltipMap" : MessageLookupByLibrary.simpleMessage("Map"),
    "searchTooltipView" : MessageLookupByLibrary.simpleMessage("View"),
    "settingsCopyright" : MessageLookupByLibrary.simpleMessage("© 2020 MTS BreakQ"),
    "settingsHomepageConfirmation" : MessageLookupByLibrary.simpleMessage("Want to visit the template homepage?"),
    "settingsListDarkMode" : MessageLookupByLibrary.simpleMessage("Dark mode"),
    "settingsListLanguage" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsListPrivacy" : MessageLookupByLibrary.simpleMessage("Privacy policy"),
    "settingsListTerms" : MessageLookupByLibrary.simpleMessage("Terms of usage"),
    "settingsListTitleMobile" : MessageLookupByLibrary.simpleMessage("Mobile No."),
    "settingsListTitleSupport" : MessageLookupByLibrary.simpleMessage("Support"),
    "settingsTitle" : MessageLookupByLibrary.simpleMessage("Settings"),
    "signInButton" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInButtonLogin" : MessageLookupByLibrary.simpleMessage("Send OTP"),
    "signInButtonRegister" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "signInDontHaveAccount" : MessageLookupByLibrary.simpleMessage("Don\'t have an account? Sign Up"),
    "signInFormMobileTitle" : MessageLookupByLibrary.simpleMessage("Login with your phone number"),
    "signInFormTitle" : MessageLookupByLibrary.simpleMessage("Welcome to BreakQ"),
    "signInHintPhone" : MessageLookupByLibrary.simpleMessage("Enter Phone Number"),
    "signInOTPAutoVerify" : MessageLookupByLibrary.simpleMessage("Auto verifying OTP"),
    "signInOTPButtonLogin" : MessageLookupByLibrary.simpleMessage("Verify OTP"),
    "signInOTPFormTitle" : MessageLookupByLibrary.simpleMessage("Enter the OTP sent to your phone"),
    "signInOTPResend" : MessageLookupByLibrary.simpleMessage("Resend OTP"),
    "signInOTPResendTitle" : MessageLookupByLibrary.simpleMessage("Didn\'t recieve the OTP yet?"),
    "signInOTPTitle" : MessageLookupByLibrary.simpleMessage("OTP Verification"),
    "signInRegisterLabel" : MessageLookupByLibrary.simpleMessage("An SMS will we sent to you on this number.\nStandard SMS charges apply."),
    "signInTitle" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "signUpAlreadyHaveAccount" : MessageLookupByLibrary.simpleMessage("Already have an account? Sign In"),
    "signUpBtnSend" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "signUpErrorConsent" : MessageLookupByLibrary.simpleMessage("You must accept the Terms and Conditions of Service to continue."),
    "signUpHelptextPassword" : m22,
    "signUpHintFullName" : MessageLookupByLibrary.simpleMessage("Your full name"),
    "signUpLabelConsent" : MessageLookupByLibrary.simpleMessage("I have read and agree with the User Terms of Service and I understand that my personal data will be processed in accordance with Privacy Statement."),
    "signUpLabelFullName" : MessageLookupByLibrary.simpleMessage("Full name"),
    "signUpLabelPhone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "signUpReadMore" : MessageLookupByLibrary.simpleMessage("View the legal documents"),
    "signUpTitle" : MessageLookupByLibrary.simpleMessage("Create an account"),
    "takePictureTitle" : MessageLookupByLibrary.simpleMessage("Take a picture")
  };
}
