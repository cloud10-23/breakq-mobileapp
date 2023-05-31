import 'dart:async';

import 'package:breakq/screens/onboarding/sign_in/sign_in_base.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/theme_text_input.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Signin widget to be used wherever we need user to log in before taking any
/// action.
class SignInOTPWidget extends StatefulWidget {
  const SignInOTPWidget({
    Key key,
    this.phoneNumber,
  }) : super(key: key);

  /// Optional widget title.
  final String phoneNumber;

  @override
  _SignInOTPWidgetState createState() => _SignInOTPWidgetState();
}

class _SignInOTPWidgetState extends State<SignInOTPWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ThemeTextInputState> keyOTPInput =
      GlobalKey<ThemeTextInputState>();
  StreamController<ErrorAnimationType> _errorController;
  TextEditingController _otpController;

  AnimationController _controller;

  AuthBloc _loginBloc;
  String _code = '';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    _loginBloc = BlocProvider.of<AuthBloc>(context);
    _errorController = StreamController<ErrorAnimationType>();
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitOTP(String code) {
    _loginBloc.add(OTPVerificationAuthEvent(otp: code));
  }

  @override
  Widget build(BuildContext context) {
    return SignInBase(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kCardRadius),
            topRight: Radius.circular(kCardRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(Feather.arrow_left_circle),
                  onPressed: () => Navigator.pop(context),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: kPaddingL, bottom: kPaddingL),
                  child: Text(
                    L10n.of(context).signInOTPTitle,
                    style: Theme.of(context).textTheme.headline6.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: kPaddingL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
              child: Row(
                children: [
                  Text(
                    L10n.of(context).signInOTPAutoVerify,
                    style: Theme.of(context).textTheme.caption.w800,
                  ),
                  Spacer(),
                  SizedBox(
                      height: kPaddingL,
                      width: kPaddingL,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      )),
                  Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
            SizedBox(height: kPaddingL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                autoFocus: true,
                keyboardType: TextInputType.number,
                animationType: AnimationType.slide,
                animationDuration: Duration(milliseconds: 100),
                animationCurve: Curves.fastOutSlowIn,
                showCursor: false,
                textStyle: Theme.of(context).textTheme.headline6.w400.copyWith(
                      fontFamily: kNumberFontFamily,
                    ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: kBlack,
                  selectedColor: kBlue900,
                  inactiveColor: kBlack,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  // activeFillColor: Colors.white,
                ),
                enableActiveFill: false,
                errorAnimationController: _errorController,
                controller: _otpController,
                // onChanged: (value) {},
                onCompleted: (code) {
                  _submitOTP(_code);
                },
                onChanged: (value) {
                  // print(value);
                  setState(() {
                    _code = value;
                  });
                },
                beforeTextPaste: (text) {
                  if (int.tryParse(text) != null && text.length == 6) {
                    print("Allowing to paste $text");
                    return true;
                  }
                  // if(text.contains(RegExp('[\d]*')))
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return false;
                },
              ),
            ),
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  current is LoginFailureAuthState,
              listener: (BuildContext context, AuthState loginListener) {
                print("login error check");
                if (loginListener is LoginFailureAuthState) {
                  _otpController.clear();
                  _errorController.add(ErrorAnimationType.shake);
                  Future.delayed(Duration(seconds: 1))
                      .then((value) => UI.showErrorDialog(
                            context,
                            message: loginListener?.message ??
                                "There was an un-expected error",
                          ));
                }
              },
              child: Container(),
              //   child: ThemeButton(
              //     onPressed: () => _submitOTP(_code),
              //     text: L10n.of(context).signInOTPButtonLogin,
              //     showLoading: login is ProcessInProgressAuthState,
              //     disableTouchWhenLoading: true,
              //   ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingL, vertical: kPaddingS),
              child: Column(
                children: [
                  Text(
                    L10n.of(context).signInOTPResendTitle,
                    style: Theme.of(context).textTheme.bodyText1.w500,
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      L10n.of(context).signInOTPResend,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .fs14
                          .w800
                          .primaryColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
