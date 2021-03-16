import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/onboarding/sign_in/sign_in_main.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreen> {
  GlobalKey<NavigatorState> globalKeyOnboardingNavigator;

  @override
  void initState() {
    super.initState();
    globalKeyOnboardingNavigator = GlobalKey(debugLabel: "OnboardingNavigator");
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (globalKeyOnboardingNavigator.currentState.canPop())
      return !await globalKeyOnboardingNavigator.currentState.maybePop();
    bool exit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App?'),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('Yes',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kBlack)),
                  onPressed: () => Navigator.pop(context, true),
                ),
                OutlinedButton(
                  child: Text('No',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kBlack)),
                  onPressed: () => Navigator.pop(context, false),
                )
              ],
            ));
    return exit;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: kWhite,
        body: BlocListener<AuthBloc, AuthState>(
          // listenWhen: (previous, current) => current is LoginSuccessAuthState,
          listenWhen: (previous, current) => (current is VerifyOTPAuthState ||
              current is InitialAuthState ||
              current is LoginSuccessAuthState),
          listener: (context, state) {
            if (state is LoginSuccessAuthState) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("<<API CALL>>"),
                        content: Text(
                            "The Phone/Google/Facebook login was succesfull " +
                                " this firebase ID will be sent to the server to check if it already exists. " +
                                "For now select whether the user exists or not!"),
                        actions: <Widget>[
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              BlocProvider.of<ApplicationBloc>(context)
                                  .add(OnboardingCompletedApplicationEvent());
                            },
                            child: Text("User exists",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: kBlack)),
                          ),
                          OutlinedButton(
                            child: Text('User is new',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: kBlack)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
            } else if (state is VerifyOTPAuthState)
              globalKeyOnboardingNavigator.currentState
                  .pushNamed(OnboardingRoutes.otp);
            else
              globalKeyOnboardingNavigator.currentState.pushNamedAndRemoveUntil(
                  OnboardingRoutes.home, (Route<dynamic> route) => false);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.introScreen),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              OnboardingNavigator(
                navigatorKey: globalKeyOnboardingNavigator,
                homeScreen: IntroMain(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
