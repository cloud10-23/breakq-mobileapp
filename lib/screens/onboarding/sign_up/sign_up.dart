import 'package:breakq/blocs/application/application_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/edit_profile/profile_image_editor.dart';
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

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() {
    return _SignUpWidgetState();
  }
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textEmailController = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final GlobalKey<FormState> keyPhoneInput = GlobalKey<FormState>();

  bool _consentGiven = true;

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
          email: _textEmailController.text,
          photoUrl: "TODO"));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Try to ge tthe User details from the User AppGlobal
    final String _userName = getIt.get<AppGlobals>().user?.displayName;
    if (_userName?.isNotEmpty ?? false) _textNameController.text = _userName;
    final String _email = getIt.get<AppGlobals>().user?.email;
    if (_email?.isNotEmpty ?? false) _textEmailController.text = _email;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kCardRadius),
              topRight: Radius.circular(kCardRadius),
            ),
          ),
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
                      padding: const EdgeInsets.only(
                          top: kPaddingL, bottom: kPaddingL),
                      child: Text(
                        "Complete your profile",
                        style: Theme.of(context).textTheme.headline5.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ProfileImageEditor(),
                    const SizedBox(height: kPaddingM),
                    FormLabel(text: L10n.of(context).signUpLabelFullName),
                    const SizedBox(height: kPaddingM),
                    TextFormField(
                      controller: _textNameController,
                      focusNode: _focusName,
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyText1.w600,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Enter your Full Name",
                          errorStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .w600
                              .copyWith(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kFormFieldsRadius),
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.caption.w700),
                      onFieldSubmitted: (String text) {
                        FormUtils.fieldFocusChange(
                            context, _focusName, _focusEmail);
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
                    FormLabel(text: "E-Mail"),
                    const SizedBox(height: kPaddingM),
                    TextFormField(
                      controller: _textEmailController,
                      focusNode: _focusEmail,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyText1.w600,
                      decoration: InputDecoration(
                          hintText: "Enter your E-mail (optional)",
                          errorStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .w600
                              .copyWith(color: Colors.red),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kFormFieldsRadius),
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.caption.w700),
                      onFieldSubmitted: (_) => _signUp(),
                      // onTapIcon: () async {
                      //   await Future<dynamic>.delayed(
                      //       const Duration(milliseconds: 100));
                      //   _textNameController.clear();
                      // },
                      validator: FormValidator.validators(
                        [
                          FormValidator.isEmail("Please enter a valid email"),
                        ],
                      ),
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
                            } else if (authState
                                is ProfileUpdateSuccessAuthState) {
                              if (Navigator.of(context).canPop())
                                Navigator.of(context).pop();
                              BlocProvider.of<ApplicationBloc>(context)
                                  .add(OnboardingCompletedApplicationEvent());
                            }
                          },
                          child: ThemeButton(
                            onPressed: _signUp,
                            text: "Finish",
                            showLoading:
                                authState is ProcessInProgressAuthState,
                            disableTouchWhenLoading: true,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: kPaddingL),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
