import 'package:breakq/data/models/country.dart';
import 'package:breakq/widgets/sigin_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/form_utils.dart';
import 'package:breakq/utils/form_validator.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_text_input.dart';
import 'package:breakq/utils/text_style.dart';

/// Signin widget to be used wherever we need user to log in before taking any
/// action.
class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key key,
    this.title,
  }) : super(key: key);

  /// Optional widget title.
  final String title;

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textPhoneController = TextEditingController();

  final GlobalKey<ThemeTextInputState> keyPhoneInput =
      GlobalKey<ThemeTextInputState>();

  AnimationController _controller;

  AuthBloc _loginBloc;

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

  void _validateForm() {
    FormUtils.hideKeyboard(context);

    if (keyPhoneInput.currentState.validate()) {
      _loginBloc.add(LoginRequestedAuthEvent(
        phone: "+91" + _textPhoneController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: kPaddingL, right: kPaddingL),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingL, bottom: kPaddingL),
                    child: Text(
                      L10n.of(context).signInFormTitle,
                      style: Theme.of(context).textTheme.headline5.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingL, bottom: kPaddingL),
                    child: Text(
                      L10n.of(context).signInFormMobileTitle,
                      style: Theme.of(context).textTheme.bodyText1.w300,
                    ),
                  ),
                  ThemeTextInput(
                    key: keyPhoneInput,
                    controller: _textPhoneController,
                    hintText: L10n.of(context).signInHintPhone,
                    keyboardType: TextInputType.phone,
                    prefix: ShowSelectedCountry(
                      /// Implement many countries in future!
                      country: Country(
                        code: "IN",
                        flag: "🇮🇳",
                        dialCode: "+91",
                        name: "India",
                      ),
                      onPressed: () {
                        //Implemented in future!
                      },
                    ),
                    onSubmitted: (String text) => _validateForm(),
                    validator: FormValidator.validators([
                      FormValidator.isRequired(
                          L10n.of(context).formValidatorRequired),
                      FormValidator.isMinLength(
                          length: 10,
                          errorMessage: "Please enter a 10 digit number"),
                      FormValidator.isMaxLength(
                          length: 10,
                          errorMessage: "Please enter a 10 digit number"),
                    ]),
                  ),
                  const SizedBox(height: kPaddingL * 1.5),
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
                          onPressed: _validateForm,
                          text: L10n.of(context).signInButtonLogin,
                          showLoading: login is ProcessInProgressAuthState,
                          disableTouchWhenLoading: true,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: kPaddingL * 1.5),
                  Image(image: AssetImage(AssetsImages.orDivider)),
                  SizedBox(height: kPaddingL),
                  SignInSocialButton(social: Social.google),
                  SignInSocialButton(social: Social.facebook),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingL),
          child: Text(
            L10n.of(context).signInRegisterLabel,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
