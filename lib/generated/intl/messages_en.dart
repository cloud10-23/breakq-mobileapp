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

  static m0(sort) => "${Intl.select(sort, {'date_asc': 'Oldest first', 'date_desc': 'Newest first', 'other': 'Other', })}";

  static m1(status) => "${Intl.select(status, {'active': 'Active', 'completed': 'Completed', 'other': 'Other', })}";

  static m2(number) => "Call number ${number}?";

  static m3(current, total) => "Step ${current} of ${total}";

  static m4(page) => "${Intl.select(page, {'page1': 'Select Bills', 'page2': 'Select Products', })}";

  static m5(status) => "${Intl.select(status, {'active': 'active', 'canceled': 'canceled', 'completed': 'completed', 'declined': 'declined', 'failed': 'failed', 'other': 'unknown', })}";

  static m6(value) => "₹ ${value}";

  static m7(mode) => "${Intl.select(mode, {'dynamic': 'Dynamic', 'alwaysOn': 'Always on', 'alwaysOff': 'Always off', 'other': 'Unknown', })}";

  static m8(value) => "${value} min";

  static m9(mins) => "in 1 hour, ${mins} mins";

  static m10(hours) => "in 1 day, ${hours} hours";

  static m11(days) => "in ${days} days";

  static m12(hours) => "in ${hours} hours";

  static m13(mins) => "in ${mins} mins";

  static m14(locale) => "${Intl.select(locale, {'en': 'English', 'de': 'Deutch', 'other': 'Unknown', })}";

  static m15(day) => "${Intl.select(day, {'january': 'January', 'february': 'February', 'march': 'March', 'april': 'April', 'may': 'May', 'june': 'June', 'july': 'July', 'august': 'August', 'september': 'September', 'october': 'October', 'november': 'November', 'december': 'December', 'other': 'Unknown', })}";

  static m16(day) => "${Intl.select(day, {'january': 'Jan', 'february': 'Feb', 'march': 'Mar', 'april': 'Apr', 'may': 'May', 'june': 'Jun', 'july': 'Jul', 'august': 'Aug', 'september': 'Sep', 'october': 'Oct', 'november': 'Nov', 'december': 'Dec', 'other': 'Unknown', })}";

  static m17(source) => "${Intl.select(source, {'gallery': 'Photo gallery', 'camera': 'Phone camera', })}";

  static m18(day) => "${Intl.select(day, {'monday': 'Monday', 'tuesday': 'Tuesday', 'wednesday': 'Wednesday', 'thursday': 'Thursday', 'friday': 'Friday', 'saturday': 'Saturday', 'sunday': 'Sunday', 'other': 'Unknown', })}";

  static m19(day) => "${Intl.select(day, {'monday': 'Mon', 'tuesday': 'Tue', 'wednesday': 'Wed', 'thursday': 'Thu', 'friday': 'Fri', 'saturday': 'Sat', 'sunday': 'Sun', 'other': 'Unknown', })}";

  static m20(length) => "Min. length is ${length} characters";

  static m21(name) => "Hi, ${name}";

  static m22(code) => "Get Salon and use code ${code} to get US\$5 off your first booking expenses.";

  static m23(num) => "${num} services available";

  static m24(number) => "Call number ${number}?";

  static m25(date) => "Replied on ${date}";

  static m26(num) => "${num} reviews";

  static m27(num) => "${num} characters remaining";

  static m28(from, to) => "₹ ${from} - ₹ ${to}";

  static m29(num) => "${num}+ Stars";

  static m30(num) => "Locations (${num})";

  static m31(length) => "Password must be at least ${length} characters long and contain at least one number and one uppercase letter.";

  static m32(date) => "Valid until: ${date}";

  static m33(date) => "Expired on: ${date}";

  static m34(date) => "Redeemed on: ${date}";

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
    "addPaymentCardButton" : MessageLookupByLibrary.simpleMessage("Save Card"),
    "addPaymentCardTitle" : MessageLookupByLibrary.simpleMessage("Add card"),
    "appointmentsBtnExplore" : MessageLookupByLibrary.simpleMessage("Explore salons nearby"),
    "appointmentsSort" : m0,
    "appointmentsStatusGroup" : m1,
    "appointmentsTitle" : MessageLookupByLibrary.simpleMessage("Appointments"),
    "appointmentsWarningCompletedList" : MessageLookupByLibrary.simpleMessage("No previous appointments found."),
    "appointmentsWarningOtherList" : MessageLookupByLibrary.simpleMessage("No appointment found that matches your search criteria."),
    "appointmentsWarningUpcomingList" : MessageLookupByLibrary.simpleMessage("No upcoming appointments found."),
    "appointmentsWelcomeSignInBtn" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "appointmentsWelcomeSignInLabel" : MessageLookupByLibrary.simpleMessage("Already registered?"),
    "appointmentsWelcomeSubtitle" : MessageLookupByLibrary.simpleMessage("Explore and book your first appointment"),
    "appointmentsWelcomeTitle" : MessageLookupByLibrary.simpleMessage("My Appointments"),
    "bookingAddNotes" : MessageLookupByLibrary.simpleMessage("Add booking notes"),
    "bookingCallConfirmation" : m2,
    "bookingLabelSteps" : m3,
    "bookingSubtitleAppointment" : MessageLookupByLibrary.simpleMessage("Appointment"),
    "bookingSubtitleCheckout" : MessageLookupByLibrary.simpleMessage("Checkout"),
    "bookingSubtitleLocation" : MessageLookupByLibrary.simpleMessage("Verify Details and Place Order"),
    "bookingSubtitleServices" : MessageLookupByLibrary.simpleMessage("Services"),
    "bookingTitleWizardPage" : m4,
    "categoriesTitle" : MessageLookupByLibrary.simpleMessage("Categories"),
    "chatOnlineLabel" : MessageLookupByLibrary.simpleMessage("Online"),
    "chatPlaceholder" : MessageLookupByLibrary.simpleMessage("Type a message..."),
    "commonAppointmentStatus" : m5,
    "commonBtnApply" : MessageLookupByLibrary.simpleMessage("Apply"),
    "commonBtnCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonBtnClose" : MessageLookupByLibrary.simpleMessage("Close"),
    "commonBtnOk" : MessageLookupByLibrary.simpleMessage("Ok"),
    "commonCurrencyFormat" : m6,
    "commonDarkMode" : m7,
    "commonDialogsErrorTitle" : MessageLookupByLibrary.simpleMessage("Oops!"),
    "commonDurationFormat" : m8,
    "commonElapseHhourMins" : m9,
    "commonElapsedDayHours" : m10,
    "commonElapsedDays" : m11,
    "commonElapsedHours" : m12,
    "commonElapsedMins" : m13,
    "commonElapsedNow" : MessageLookupByLibrary.simpleMessage("in process"),
    "commonLocales" : m14,
    "commonLocationFavorited" : MessageLookupByLibrary.simpleMessage("Location added to your favorites list."),
    "commonLocationUnfavorited" : MessageLookupByLibrary.simpleMessage("Location removed from your favorites list."),
    "commonMonthLong" : m15,
    "commonMonthShort" : m16,
    "commonPhotoSources" : m17,
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
    "commonSortHTL" : MessageLookupByLibrary.simpleMessage("Price High-Low"),
    "commonSortLTL" : MessageLookupByLibrary.simpleMessage("Price Low-High"),
    "commonTooltipInfo" : MessageLookupByLibrary.simpleMessage("Info"),
    "commonTooltipRefresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "commonWeekdayLong" : m18,
    "commonWeekdayShort" : m19,
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
    "favoritesNoResults" : MessageLookupByLibrary.simpleMessage("Your favorites list is empty."),
    "favoritesTitle" : MessageLookupByLibrary.simpleMessage("My favorites"),
    "favoritesTitleNoResults" : MessageLookupByLibrary.simpleMessage("No favorites yet"),
    "forgotPasswordBack" : MessageLookupByLibrary.simpleMessage("Back to login"),
    "forgotPasswordBtn" : MessageLookupByLibrary.simpleMessage("Reset Password"),
    "forgotPasswordDialogText" : MessageLookupByLibrary.simpleMessage("Secure link to reset your password has been sent to the provided email address."),
    "forgotPasswordDialogTitle" : MessageLookupByLibrary.simpleMessage("Secure link has been sent"),
    "forgotPasswordLabel" : MessageLookupByLibrary.simpleMessage("Enter your registered email address and we shall send you a secure link to reset your password."),
    "forgotPasswordTitle" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "formValidatorEmail" : MessageLookupByLibrary.simpleMessage("Email format invalid"),
    "formValidatorInvalidPassword" : MessageLookupByLibrary.simpleMessage("Password format invalid"),
    "formValidatorMinLength" : m20,
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
    "homeTitleUser" : m21,
    "inboxSlideButtonArchive" : MessageLookupByLibrary.simpleMessage("Archive"),
    "inboxSlideButtonDelete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "inboxTitle" : MessageLookupByLibrary.simpleMessage("Messages"),
    "inviteButton" : MessageLookupByLibrary.simpleMessage("Share your code"),
    "inviteDescription" : MessageLookupByLibrary.simpleMessage("Invite your friends and give them each US\$5 in coupons. And for every friend who completes their first booking process, we will give you a US\$5 coupon!"),
    "inviteEarningsLabel" : MessageLookupByLibrary.simpleMessage("Total Earnings"),
    "inviteShareText" : m22,
    "inviteSubtitle" : MessageLookupByLibrary.simpleMessage("Get discounts by inviting friends"),
    "inviteTitle" : MessageLookupByLibrary.simpleMessage("Invite friends"),
    "locationAvailableServies" : m23,
    "locationCallConfirmation" : m24,
    "locationClosed" : MessageLookupByLibrary.simpleMessage("Closed"),
    "locationCurrentlyClosed" : MessageLookupByLibrary.simpleMessage("Currently closed"),
    "locationInstantConfirmation" : MessageLookupByLibrary.simpleMessage("Instant confirmation!"),
    "locationLabelGenders" : MessageLookupByLibrary.simpleMessage("Genders"),
    "locationLabelPhone" : MessageLookupByLibrary.simpleMessage("Phone"),
    "locationLabelWeb" : MessageLookupByLibrary.simpleMessage("Web"),
    "locationLabelWorkingHours" : MessageLookupByLibrary.simpleMessage("Working hours"),
    "locationLinkAllReviews" : MessageLookupByLibrary.simpleMessage("See all reviews"),
    "locationLinkAllServices" : MessageLookupByLibrary.simpleMessage("See all services"),
    "locationNoResults" : MessageLookupByLibrary.simpleMessage("No Products found! Check back later!"),
    "locationRepliedOn" : m25,
    "locationTitleAboutUs" : MessageLookupByLibrary.simpleMessage("About Us"),
    "locationTitleNearby" : MessageLookupByLibrary.simpleMessage("Nearby Locations"),
    "locationTitleRatings" : MessageLookupByLibrary.simpleMessage("Ratings"),
    "locationTitleReviews" : MessageLookupByLibrary.simpleMessage("Reviews"),
    "locationTitleStaff" : MessageLookupByLibrary.simpleMessage("Our Staff"),
    "locationTitleTopServices" : MessageLookupByLibrary.simpleMessage("Top Services"),
    "locationTotalReviews" : m26,
    "locationWebConfirmation" : MessageLookupByLibrary.simpleMessage("Open web page?"),
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
    "paymentCardTitle" : MessageLookupByLibrary.simpleMessage("Payment card"),
    "paymentCardWarningBtn" : MessageLookupByLibrary.simpleMessage("+ Add your card"),
    "paymentCardWarningNote" : MessageLookupByLibrary.simpleMessage("You can use your debit or credit card to book an appointment (card will not be charged until all the booked services are complete)."),
    "paymentCardWarningTitle" : MessageLookupByLibrary.simpleMessage("No card available"),
    "paymentCardWidgetCardHolderLabel" : MessageLookupByLibrary.simpleMessage("Card holder name"),
    "paymentCardWidgetCardHolderPlaceholder" : MessageLookupByLibrary.simpleMessage("CARD HOLDER"),
    "paymentCardWidgetCardNumberLabel" : MessageLookupByLibrary.simpleMessage("Card number"),
    "paymentCardWidgetExpirationDateLabel" : MessageLookupByLibrary.simpleMessage("Expiration date"),
    "paymentCardWidgetExpirationDatePlaceholder" : MessageLookupByLibrary.simpleMessage("MM/YY"),
    "paymentCardWidgetSecurityCodeLabel" : MessageLookupByLibrary.simpleMessage("Security code"),
    "paymentCardWidgetValidityLabel" : MessageLookupByLibrary.simpleMessage("VALID THRU"),
    "pickerBtnSelect" : MessageLookupByLibrary.simpleMessage("Select"),
    "pickerPlaceholderSearch" : MessageLookupByLibrary.simpleMessage("Search"),
    "pickerTitleCity" : MessageLookupByLibrary.simpleMessage("Select Location"),
    "pickerTitleDate" : MessageLookupByLibrary.simpleMessage("Select Date"),
    "pickerTitleLanguages" : MessageLookupByLibrary.simpleMessage("Select Language"),
    "productButtonAddToCart" : MessageLookupByLibrary.simpleMessage("Add to cart"),
    "profileListAppointments" : MessageLookupByLibrary.simpleMessage("My appointments"),
    "profileListEdit" : MessageLookupByLibrary.simpleMessage("Edit profile"),
    "profileListFavorites" : MessageLookupByLibrary.simpleMessage("My favorites"),
    "profileListInvite" : MessageLookupByLibrary.simpleMessage("Invite friends"),
    "profileListLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "profileListPaymentCard" : MessageLookupByLibrary.simpleMessage("Payment card"),
    "profileListReviews" : MessageLookupByLibrary.simpleMessage("My reviews"),
    "profileListSettings" : MessageLookupByLibrary.simpleMessage("More settings"),
    "profileListTitleSettings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "profileListVouchers" : MessageLookupByLibrary.simpleMessage("My vouchers"),
    "reviewCommentPlaceholder" : MessageLookupByLibrary.simpleMessage("Write your review here..."),
    "reviewLabelComment" : MessageLookupByLibrary.simpleMessage("Your Comment (optional)"),
    "reviewLabelRate" : MessageLookupByLibrary.simpleMessage("What\'s Your Rate?"),
    "reviewLengthLimit" : m27,
    "reviewSubmitBtn" : MessageLookupByLibrary.simpleMessage("Submit Review"),
    "reviewSuccessSubtitle" : MessageLookupByLibrary.simpleMessage("Your feedback has been received and will appear immediately."),
    "reviewSuccessTitle" : MessageLookupByLibrary.simpleMessage("Thank you"),
    "reviewTitle" : MessageLookupByLibrary.simpleMessage("Rate Your Experience"),
    "reviewWarning" : MessageLookupByLibrary.simpleMessage("Please rate this salon by clicking on the number of stars you want to assign."),
    "reviewsTitle" : MessageLookupByLibrary.simpleMessage("My Reviews"),
    "searchBtnGroupAll" : MessageLookupByLibrary.simpleMessage("All"),
    "searchBtnGroupGrocery" : MessageLookupByLibrary.simpleMessage("Grocery"),
    "searchDrawerDistanceRange" : m28,
    "searchLabelAll" : MessageLookupByLibrary.simpleMessage("All"),
    "searchLabelNearby" : MessageLookupByLibrary.simpleMessage("Nearby"),
    "searchLabelQuickSearch" : MessageLookupByLibrary.simpleMessage("What are you looking for?"),
    "searchLabelRatingFilter" : m29,
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
    "searchTitleResults" : m30,
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
    "signUpHelptextPassword" : m31,
    "signUpHintFullName" : MessageLookupByLibrary.simpleMessage("Your full name"),
    "signUpLabelConsent" : MessageLookupByLibrary.simpleMessage("I have read and agree with the User Terms of Service and I understand that my personal data will be processed in accordance with Privacy Statement."),
    "signUpLabelFullName" : MessageLookupByLibrary.simpleMessage("Full name"),
    "signUpLabelPhone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "signUpReadMore" : MessageLookupByLibrary.simpleMessage("View the legal documents"),
    "signUpTitle" : MessageLookupByLibrary.simpleMessage("Create an account"),
    "takePictureTitle" : MessageLookupByLibrary.simpleMessage("Take a picture"),
    "voucherLabelCouponCode" : MessageLookupByLibrary.simpleMessage("Coupon Code"),
    "voucherLabelSpecialTerms" : MessageLookupByLibrary.simpleMessage("Special Terms And Conditions"),
    "vouchersDueDateActive" : m32,
    "vouchersDueDateExpired" : m33,
    "vouchersDueDateRedeemed" : m34,
    "vouchersHeroNoteActive" : MessageLookupByLibrary.simpleMessage("No available coupon found."),
    "vouchersHeroNoteExpired" : MessageLookupByLibrary.simpleMessage("No coupon expired so far."),
    "vouchersHeroNoteRedeemed" : MessageLookupByLibrary.simpleMessage("You have not used any of your coupons so far."),
    "vouchersInfo" : MessageLookupByLibrary.simpleMessage("Here you can see a list of your coupons that you can use the next time you visit a particular location. When paying the bill for a certain service, the final amount will be reduced by the amount indicated on the coupon."),
    "vouchersLabelOff" : MessageLookupByLibrary.simpleMessage("off the final price"),
    "vouchersTabActive" : MessageLookupByLibrary.simpleMessage("Active"),
    "vouchersTabExpired" : MessageLookupByLibrary.simpleMessage("Expired"),
    "vouchersTabRedeemed" : MessageLookupByLibrary.simpleMessage("Redeemed"),
    "vouchersTitle" : MessageLookupByLibrary.simpleMessage("My vouchers"),
    "walletBalance" : MessageLookupByLibrary.simpleMessage("₹ 0.00"),
    "walletTitle" : MessageLookupByLibrary.simpleMessage("Wallet")
  };
}
