import 'package:breakq/data/models/country.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/sigin_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/form_utils.dart';
import 'package:breakq/utils/form_validator.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_text_input.dart';
import 'package:breakq/utils/text_style.dart';

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
  final TextEditingController _textOTPController = TextEditingController();

  final GlobalKey<ThemeTextInputState> keyOTPInput =
      GlobalKey<ThemeTextInputState>();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  AnimationController _controller;

  AuthBloc _loginBloc;
  String _code = '';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    _loginBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 50.0,
        width: kPaddingL,
        child: TextField(
          key: Key(key),
          expands: false,
          // autofocus: key.contains("1") ? true : false,
          autofocus: false,
          focusNode: focusNode,
          onSubmitted: (_) => _submitOTP(),
          onChanged: (String value) {
            if (value.length == 1) {
              _code += value;
              switch (_code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                case 6:

                  /// Submit the OTP
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6.w600,
          decoration:
              InputDecoration(contentPadding: const EdgeInsets.all(kPaddingS)),
        ),
      );

  void _submitOTP() {
    FormUtils.hideKeyboard(context);

    _loginBloc.add(OTPVerificationAuthEvent(otp: _code));
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
              padding: const EdgeInsets.only(left: kPaddingM, right: kPaddingM),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => _loginBloc.add(OTPGoBackAuthEvent()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingL, bottom: kPaddingL),
                          child: Text(
                            L10n.of(context).signInOTPTitle,
                            style: Theme.of(context).textTheme.headline5.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: kPaddingL),
                      child: Text(
                        L10n.of(context).signInOTPFormTitle,
                        style: Theme.of(context).textTheme.headline6.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          L10n.of(context).signInOTPAutoVerify,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Spacer(),
                        SizedBox(
                            height: kPaddingM,
                            width: kPaddingM,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            )),
                        Spacer(
                          flex: 5,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getPinField(key: "1", focusNode: focusNode1),
                        getPinField(key: "2", focusNode: focusNode2),
                        getPinField(key: "3", focusNode: focusNode3),
                        getPinField(key: "4", focusNode: focusNode4),
                        getPinField(key: "5", focusNode: focusNode5),
                        getPinField(key: "6", focusNode: focusNode6),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState login) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener:
                              (BuildContext context, AuthState loginListener) {
                            if (loginListener is LoginFailureAuthState) {
                              UI.showErrorDialog(
                                context,
                                message: loginListener.message,
                              );
                            } else if (loginListener is LoginSuccessAuthState) {
                              if (Navigator.of(context).canPop())
                                Navigator.of(context).pop();
                            }
                          },
                          child: ThemeButton(
                            onPressed: () => _submitOTP(),
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
                  style: Theme.of(context).textTheme.caption.fs16.w300,
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
                        .copyWith(color: kPrimaryColor),
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
