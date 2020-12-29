import 'dart:math';

import 'package:breakq/configs/routes.dart';
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
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/form_label.dart';
import 'package:breakq/widgets/link_button.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textPhoneController = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPhone = FocusNode();
  final GlobalKey<ThemeTextInputState> keyPhoneInput =
      GlobalKey<ThemeTextInputState>();
  final GlobalKey<ThemeTextInputState> keyNameInput =
      GlobalKey<ThemeTextInputState>();

  bool _consentGiven = false;

  void _signUp() {
    FormUtils.hideKeyboard(context);

    if (!_consentGiven) {
      UI.showErrorDialog(
        context,
        message: L10n.of(context).signUpErrorConsent,
        onPressed: () {},
      );
      return;
    }

    if (keyNameInput.currentState.validate() &&
        keyPhoneInput.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context).add(UserRegisteredAuthEvent(
        fullName: _textNameController.text,
        phone: _textPhoneController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kCardRadius),
                topRight: Radius.circular(kCardRadius),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: kPaddingL, right: kPaddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: kPaddingL, bottom: kPaddingL),
                      child: Text(
                        L10n.of(context).signUpTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FormLabel(text: L10n.of(context).signUpLabelFullName),
                    const SizedBox(height: kPaddingM),
                    ThemeTextInput(
                      key: keyNameInput,
                      hintText: L10n.of(context).signUpHintFullName,
                      controller: _textNameController,
                      focusNode: _focusName,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (String text) {
                        FormUtils.fieldFocusChange(
                            context, _focusName, _focusPhone);
                      },
                      onTapIcon: () async {
                        await Future<dynamic>.delayed(
                            const Duration(milliseconds: 100));
                        _textNameController.clear();
                      },
                      validator: FormValidator.isRequired(
                          L10n.of(context).formValidatorRequired),
                    ),
                    const SizedBox(height: kPaddingM),
                    FormLabel(text: L10n.of(context).signUpLabelPhone),
                    const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                    ThemeTextInput(
                      key: keyPhoneInput,
                      controller: _textPhoneController,
                      hintText: L10n.of(context).signInHintPhone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
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
                    const SizedBox(height: kPaddingL),

                    /// Consent is optional
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: kPaddingM),
                    //   child: CheckboxListTile(
                    //     contentPadding: EdgeInsets.zero,
                    //     activeColor: Theme.of(context).accentColor,
                    //     title: Text(
                    //       L10n.of(context).signUpLabelConsent,
                    //       style: Theme.of(context).textTheme.caption,
                    //     ),
                    //     value: _consentGiven,
                    //     onChanged: (bool value) {
                    //       setState(() {
                    //         _consentGiven = value;
                    //       });
                    //     },
                    //     dense: true,
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //   ),
                    // ),
                    const SizedBox(height: kPaddingM),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState authState) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener:
                              (BuildContext context, AuthState authState) {
                            if (authState is RegistrationFailureAuthState) {
                              UI.showErrorDialog(
                                context,
                                message: authState.message,
                              );
                            }
                          },
                          child: ThemeButton(
                            onPressed: _signUp,
                            text: L10n.of(context).signUpBtnSend,
                            showLoading:
                                authState is ProcessInProgressAuthState,
                            disableTouchWhenLoading: true,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: kPaddingL * 1.5),
                    Image(image: AssetImage(AssetsImages.orDivider)),
                    SizedBox(height: kPaddingM),
                    SignUpSocialButton(social: Social.google),
                    SignUpSocialButton(social: Social.facebook),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: kPaddingM),
                    //   child: LinkButton(
                    //     trailing: Icon(
                    //       Icons.open_in_browser,
                    //       color: Theme.of(context).hintColor,
                    //     ),
                    //     label: L10n.of(context).signUpReadMore,
                    //     onPressed: () {}, //Async.launchUrl(kTermsOfServiceURL),
                    //   ),
                    // ),
                    ListTile(
                      contentPadding: EdgeInsets.all(kPaddingL),
                      onTap: () =>
                          Navigator.popAndPushNamed(context, Routes.signIn),
                      title: Center(
                        child: Text(
                          L10n.of(context).signUpAlreadyHaveAccount,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
