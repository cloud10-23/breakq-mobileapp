import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/onboarding/sign_in/sigin_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/form_utils.dart';
import 'package:breakq/utils/form_validator.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/form_label.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() {
    return _SignUpWidgetState();
  }
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textPhoneController = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPhone = FocusNode();
  final GlobalKey<FormState> keyPhoneInput = GlobalKey<FormState>();

  bool _consentGiven = true;
  String _phoneNum = "";

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

    if (keyPhoneInput.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context).add(UserRegisteredAuthEvent(
        fullName: _textNameController.text,
        phone: _phoneNum,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: kPaddingL, right: kPaddingL),
        child: Theme(
          data: Theme.of(context).copyWith(primaryColor: kBlue),
          child: Form(
            key: keyPhoneInput,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: kPaddingL, bottom: kPaddingL),
                  child: Text(
                    L10n.of(context).signUpTitle,
                    style: Theme.of(context).textTheme.headline5.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                FormLabel(text: L10n.of(context).signUpLabelFullName),
                const SizedBox(height: kPaddingM),
                TextFormField(
                  controller: _textNameController,
                  focusNode: _focusName,
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context).textTheme.bodyText1.w600,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      hintText: L10n.of(context).signUpHintFullName,
                      errorStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .w600
                          .copyWith(color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kFormFieldsRadius),
                        borderSide: BorderSide(
                          width: 2,
                          color:
                              Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                      ),
                      hintStyle: Theme.of(context).textTheme.caption.w700),
                  onFieldSubmitted: (String text) {
                    FormUtils.fieldFocusChange(
                        context, _focusName, _focusPhone);
                  },
                  // onTapIcon: () async {
                  //   await Future<dynamic>.delayed(
                  //       const Duration(milliseconds: 100));
                  //   _textNameController.clear();
                  // },
                  validator: FormValidator.isRequired(
                      L10n.of(context).formValidatorNameRequired),
                ),
                const SizedBox(height: kPaddingM),
                FormLabel(text: L10n.of(context).signUpLabelPhone),
                const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                IntlPhoneField(
                  controller: _textPhoneController,
                  initialCountryCode: 'IN',
                  keyboardType: TextInputType.phone,
                  focusNode: _focusPhone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: Theme.of(context).textTheme.headline6.w400.copyWith(
                        fontFamily: kNumberFontFamily,
                      ),
                  decoration: InputDecoration(
                      errorStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .w600
                          .copyWith(color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kFormFieldsRadius),
                        borderSide: BorderSide(
                          width: 2,
                          color:
                              Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                      ),
                      hintText: L10n.of(context).signInHintPhone,
                      hintStyle: Theme.of(context).textTheme.caption.w700),
                  onChanged: (phone) {
                    _phoneNum = phone.completeNumber;
                  },
                  onSubmitted: (String text) => _signUp(),
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
                      listener: (BuildContext context, AuthState authState) {
                        if (authState is RegistrationFailureAuthState) {
                          UI.showErrorDialog(
                            context,
                            message: authState.message,
                          );
                        } else if (authState is LoginSuccessAuthState) {
                          if (Navigator.of(context).canPop())
                            Navigator.of(context).pop();
                        }
                      },
                      child: ThemeButton(
                        onPressed: _signUp,
                        text: L10n.of(context).signUpBtnSend,
                        showLoading: authState is ProcessInProgressAuthState,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                ),
                SizedBox(height: kPaddingL * 1.5),
                Image(image: AssetImage(AssetImages.orDivider)),
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
                    child: Text(L10n.of(context).signUpAlreadyHaveAccount,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .w600
                            .copyWith(color: Colors.black54)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
