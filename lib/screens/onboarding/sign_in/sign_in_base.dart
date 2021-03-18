import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class SignInBase extends StatelessWidget {
  const SignInBase({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        children: <Widget>[
          SizedBox(height: kPaddingL * 2),
          Row(
            children: [
              Spacer(),
              Image(
                image: AssetImage(AssetImages.bq_icon_alt),
                height: 80.0,
              ),
              Spacer(),
              Expanded(
                flex: 8,
                child: Text(
                  "BreakQ",
                  style: Theme.of(context).textTheme.headline4.w800.white,
                ),
              ),
            ],
          ),
          SizedBox(height: kPaddingL),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class BaseBlocWrapper extends StatefulWidget {
  BaseBlocWrapper({this.child});

  final Widget child;

  @override
  _BaseBlocWrapperState createState() => _BaseBlocWrapperState();
}

class _BaseBlocWrapperState extends State<BaseBlocWrapper> {
  Future<bool> _onBackPressed(BuildContext context) async {
    if (Navigator.canPop(context)) {
      BlocProvider.of<AuthBloc>(context).add(UserClearedAuthEvent());
      return !await Navigator.maybePop(context);
    }
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

  void _apiCall({String message, VoidCallback userNew, VoidCallback userOld}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("<<API CALL>>"),
              content: Text(
                message,
              ),
              actions: <Widget>[
                OutlinedButton(
                  onPressed: userOld,
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
                  onPressed: userNew,
                )
              ],
            ));
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
              current is LoginSuccessAuthState ||
              current is SocialLoginSuccessAuthState ||
              current is LoginSuccessWithSocialAuthState ||
              current is OnboardingCompleteAuthState ||
              current is ApiFailureAuthState),
          listener: (context, state) {
            print("Listener is being called!");
            if (state is LoginSuccessAuthState) {
              _apiCall(
                message: "The Phone login was succesfull " +
                    " this firebase ID will be sent to the server to check if it already exists. " +
                    "For now select whether the user exists or not!",
                userNew: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.o_profile, ModalRoute.withName(Routes.o_home));
                },
                userOld: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<ApplicationBloc>(context)
                      .add(OnboardingCompletedApplicationEvent());
                },
              );
            } else if (state is SocialLoginSuccessAuthState) {
              _apiCall(
                message: "The Google/ Facebook login was succesfull " +
                    " this firebase ID will be sent to the server to check if it already exists. " +
                    "For now select whether the user exists or not!",
                userNew: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Routes.o_mobileLogin,
                      arguments: "Almost there!\nEnter your mobile number");
                },
                userOld: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<ApplicationBloc>(context)
                      .add(OnboardingCompletedApplicationEvent());
                },
              );
            } else if (state is LoginSuccessWithSocialAuthState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.o_profile, ModalRoute.withName(Routes.o_home));
            } else if (state is VerifyOTPAuthState)
              Navigator.of(context).pushNamed(Routes.o_otp);
            else if (state is RegistrationFailureAuthState) {
              UI.showErrorDialog(
                context,
                message: state.message,
              );
            } else if (state is OnboardingCompleteAuthState) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              BlocProvider.of<ApplicationBloc>(context)
                  .add(OnboardingCompletedApplicationEvent());
            } else
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.o_home, (Route<dynamic> route) => false);
          },
          child: widget.child,
        ),
      ),
    );
  }
}
