import 'package:breakq/screens/onboarding/sign_in/sign_in_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/text_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen();
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  AnimationController _rippleAnimationController;
  Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();

    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _rippleAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: screenHeight,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.easeIn,
    ));

    /// Styles for the onbarding screen elements
    final PageDecoration pageDecoration = PageDecoration(
      titleTextStyle:
          Theme.of(context).textTheme.headline5.bold.copyWith(color: kWhite),
      bodyTextStyle: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: kWhite, height: 1.8),
      descriptionPadding:
          const EdgeInsets.fromLTRB(kPaddingM, 0, kPaddingM, kPaddingM),
      imagePadding: const EdgeInsets.all(kPaddingL),
      boxDecoration: BoxDecoration(
        // Linear gradient background
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const <double>[0.1, 0.9],
          colors: <Color>[
            kBlue.withOpacity(.9),
            kBlue,
          ],
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarDividerColor: null,
        statusBarColor: null,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: kWhite,
        body: Stack(
          children: <Widget>[
            IntroductionScreen(
              globalBackgroundColor: kWhite,
              showSkipButton: true,
              skipFlex: 0,
              nextFlex: 0,
              dotsDecorator: DotsDecorator(
                size: const Size(10.0, 10.0), // size of dots
                color: kWhite.withAlpha(128), // color of dots
                activeSize: const Size(22.0, 10.0),
                activeColor: kWhite, // color of the active dot
                activeShape: const RoundedRectangleBorder(
                  // Shape of the active dot.
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              skip: Text(
                L10n.of(context).onboardingBtnSkip,
                style: const TextStyle(color: kWhite),
              ),
              next: const Icon(
                Icons.arrow_forward,
                color: kWhite,
              ),
              done: Text(
                L10n.of(context).onboardingBtnGetStarted,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, color: kWhite),
              ),
              pages: <PageViewModel>[
                PageViewModel(
                  title: L10n.of(context).onboardingPage1Title,
                  body: L10n.of(context).onboardingPage1Body,
                  image: introImage(AssetImages.onboardingShopImage),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: L10n.of(context).onboardingPage2Title,
                  body: L10n.of(context).onboardingPage2Body,
                  image: introIconWhite(Ionicons.ios_barcode),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: L10n.of(context).onboardingPage3Title,
                  body: L10n.of(context).onboardingPage3Body,
                  image: introIconWhite(FontAwesome5Solid.qrcode),
                  decoration: pageDecoration,
                ),
              ],
              onDone: () => onboardingCompleted(),
              onSkip: () => onboardingCompleted(),
            ),
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (_, Widget child) {
                return ripple(
                  context,
                  radius: _rippleAnimation.value,
                  color: Theme.of(context).canvasColor,
                );
              },
            ),
            Visibility(
              visible: _rippleAnimationController.isCompleted,
              child: IntroMain(),
            ),
          ],
        ),
      ),
    );
  }

  /// Show the OnboardingScreen image widget.
  Widget introImage(String assetName) {
    return Align(
      child: Image.asset('$assetName', width: 240.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget introImageWhite(String assetName) {
    return Align(
      child: Image.asset(
        '$assetName',
        width: 240.0,
        color: kWhite,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget introIconWhite(IconData assetName) {
    return Align(
      child: Icon(
        assetName,
        size: 240.0,
        color: kWhite,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget ripple(
    BuildContext context, {
    double radius,
    Color color,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: kPaddingL - radius,
      child: Container(
        width: 2 * radius,
        height: 2 * radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  /// User finished the onbaording. Add a new event [OnboardingCompletedApplicationEvent] to [ApplicationBloc].
  Future<void> onboardingCompleted() async {
    await _rippleAnimationController.forward();
    setState(() {});

    /// Here call the Sign-In/Up and then complete onboarding!
    // _applicationBloc.add(OnboardingCompletedApplicationEvent());
  }
}
