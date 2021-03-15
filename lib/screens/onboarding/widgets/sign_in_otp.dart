import 'dart:async';

import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_text_input.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Signin widget to be used wherever we need user to log in before taking any
/// action.
class SignInOTPWidget extends StatefulWidget {
  const SignInOTPWidget({
    Key key,
    this.title,
  }) : super(key: key);

  /// Optional widget title.
  final String title;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: kPaddingL, right: kPaddingL),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Feather.arrow_left_circle),
                          onPressed: () => _loginBloc.add(OTPGoBackAuthEvent()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingL, bottom: kPaddingL),
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
                      padding: const EdgeInsets.only(bottom: kPaddingL),
                      child: Text(
                        L10n.of(context).signInOTPFormTitle,
                        style: Theme.of(context).textTheme.bodyText1.w500,
                      ),
                    ),
                    SizedBox(height: kPaddingL * 1.5),
                    Row(
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
                    SizedBox(height: kPaddingL),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.slide,
                      animationDuration: Duration(milliseconds: 100),
                      animationCurve: Curves.fastOutSlowIn,
                      showCursor: false,
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
                        _submitOTP(code);
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
                    const Padding(padding: EdgeInsets.only(top: kPaddingL)),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState login) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener:
                              (BuildContext context, AuthState loginListener) {
                            if (loginListener is LoginFailureAuthState) {
                              _otpController.clear();
                              _errorController.add(ErrorAnimationType.shake);
                              Future.delayed(Duration(seconds: 1))
                                  .then((value) => UI.showErrorDialog(
                                        context,
                                        message: loginListener.message,
                                        // onPressed: () => Navigator.pop(context),
                                      ));
                            } else if (loginListener is LoginSuccessAuthState) {
                              if (Navigator.of(context).canPop())
                                Navigator.of(context).pop();
                            }
                          },
                          child: ThemeButton(
                            onPressed: () => _submitOTP(_code),
                            text: L10n.of(context).signInOTPButtonLogin,
                            showLoading: login is ProcessInProgressAuthState,
                            disableTouchWhenLoading: true,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kPaddingL),
            child: Column(
              children: [
                Text(
                  L10n.of(context).signInOTPResendTitle,
                  style: Theme.of(context).textTheme.bodyText1.w500,
                  textAlign: TextAlign.center,
                ),
                FlatButton(
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
        ],
      ),
    );
  }
}
