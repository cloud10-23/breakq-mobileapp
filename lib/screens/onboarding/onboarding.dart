import 'package:breakq/screens/onboarding/intro_screen.dart';
import 'package:breakq/screens/onboarding/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/text_style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  AnimationController _rippleAnimationController;
  Animation<double> _rippleAnimation;

  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();

    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
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
          Theme.of(context).textTheme.headline5.bold.copyWith(color: kBlack),
      bodyTextStyle: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: kBlack, height: 1.8),
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
            kPrimaryColor.withOpacity(.9),
            kPrimaryColor,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: <Widget>[
          IntroductionScreen(
            globalBackgroundColor: kWhite,
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0), // size of dots
              color: kBlack.withAlpha(128), // color of dots
              activeSize: const Size(22.0, 10.0),
              activeColor: kBlack, // color of the active dot
              activeShape: const RoundedRectangleBorder(
                // Shape of the active dot.
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            skip: Text(
              L10n.of(context).onboardingBtnSkip,
              style: const TextStyle(color: kBlack),
            ),
            next: const Icon(
              Icons.arrow_forward,
              color: kBlack,
            ),
            done: Text(
              L10n.of(context).onboardingBtnGetStarted,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, color: kBlack),
            ),
            pages: <PageViewModel>[
              PageViewModel(
                title: L10n.of(context).onboardingPage1Title,
                body: L10n.of(context).onboardingPage1Body,
                image: introImage(AssetsImages.onboardingWelcome),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: L10n.of(context).onboardingPage2Title,
                body: L10n.of(context).onboardingPage2Body,
                image: introImage(AssetsImages.onboardingFind),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: L10n.of(context).onboardingPage3Title,
                body: L10n.of(context).onboardingPage3Body,
                image: introImage(AssetsImages.onboardingAppointment),
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
            child: IntroScreen(),
          ),
        ],
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
