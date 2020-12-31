import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/screens/onboarding/widgets/sign_in_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/onboarding/widgets/sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      buildWhen: (AuthState prevState, AuthState currentState) {
        return currentState is! LoginSuccessAuthState;
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          backgroundColor: kWhite,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.5),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsImages.loginBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kCardRadius),
                    topRight: Radius.circular(kCardRadius),
                  ),
                ),
                child: TabBarView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SignInWidget(),
                    SignInOTPWidget(),
                  ],
                ),
              )
            ],
          ),
        );
      },
      listenWhen: (previous, current) => (current is VerifyOTPAuthState ||
          current is InitialAuthState ||
          current is LoginSuccessAuthState),
      listener: (context, state) => (state is LoginSuccessAuthState)
          ? BlocProvider.of<ApplicationBloc>(context)
              .add(OnboardingCompletedApplicationEvent())
          : (state is VerifyOTPAuthState)
              ? _controller.animateTo(1)
              : _controller.animateTo(0),
    );
  }
}
