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
      BlocProvider.of<AuthBloc>(context).add(UserLoggedOutAuthEvent());
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
          listenWhen: (previous, current) => (current is OTPSentAuthState ||
              current is LoginSuccessAuthState ||
              current is LinkPhoneAuthState ||
              current is NewUserRegisterAuthState ||
              current is OnboardingCompleteAuthState ||
              current is ApiFailureAuthState),
          listener: (context, state) {
            if (state is LoginSuccessAuthState) {
              /// This is the way for existing users to complete login
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Routes.o_home));
              BlocProvider.of<ApplicationBloc>(context)
                  .add(OnboardingCompletedApplicationEvent());
            } else if (state is LinkPhoneAuthState) {
              /// After they login with Social account, if the user is new
              Navigator.of(context).pushNamed(Routes.o_mobileLogin,
                  arguments: "Almost there!\nEnter your mobile number");
            } else if (state is OTPSentAuthState) {
              Navigator.of(context).pushNamed(Routes.o_otp);
            } else if (state is NewUserRegisterAuthState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.o_profile, ModalRoute.withName(Routes.o_home));
            } else if (state is OnboardingCompleteAuthState) {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Routes.o_home));
              BlocProvider.of<ApplicationBloc>(context)
                  .add(OnboardingCompletedApplicationEvent());
            } else if (state is RegistrationFailureAuthState) {
              UI.showErrorDialog(
                context,
                message: state.message,
              );
            } else if (state is LoginFailureAuthState) {
              /// Exccept this Api Failure, anything else go back to home screen
            } else
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Routes.o_home));
          },
          child: widget.child,
        ),
      ),
    );
  }
}
