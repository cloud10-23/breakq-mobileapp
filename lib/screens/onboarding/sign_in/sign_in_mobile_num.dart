import 'package:breakq/screens/onboarding/sign_in/sign_in_base.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/form_utils.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final GlobalKey<FormState> keyPhoneInput = GlobalKey<FormState>();

  AnimationController _controller;

  AuthBloc _loginBloc;

  String _phoneNum;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    _loginBloc = BlocProvider.of<AuthBloc>(context);

    _phoneNum = "";

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _validateForm() async {
    FormUtils.hideKeyboard(context);

    if (keyPhoneInput.currentState.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("phone", _phoneNum);
      _loginBloc.add(LoginRequestedAuthEvent(
        phone: _phoneNum,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInBase(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: kPaddingL, right: kPaddingL),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingL, bottom: kPaddingL),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Feather.arrow_left_circle),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            widget.title ?? "Enter your mobile number",
                            style:
                                Theme.of(context).textTheme.headline6.fs18.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(primaryColor: kBlue),
                    child: Form(
                      key: keyPhoneInput,
                      child: IntlPhoneField(
                        // focusNode: FocusNode()..requestFocus(),
                        controller: _textPhoneController,
                        initialCountryCode: 'IN',
                        keyboardType: TextInputType.phone,
                        style:
                            Theme.of(context).textTheme.headline6.w400.copyWith(
                                  fontFamily: kNumberFontFamily,
                                ),
                        decoration: InputDecoration(
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
                            hintText: L10n.of(context).signInHintPhone,
                            hintStyle:
                                Theme.of(context).textTheme.caption.w700),
                        onChanged: (phone) {
                          _phoneNum = phone.completeNumber;
                        },
                        onSubmitted: (String text) => _validateForm(),
                      ),
                    ),
                  ),
                  const SizedBox(height: kPaddingL * 2),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return ThemeButton(
                      showLoading: state is LoadingAuthState,
                      disableTouchWhenLoading: true,
                      onPressed: () => _validateForm(),
                      text: "Verify",
                    );
                  }),
                  const SizedBox(height: kPaddingL * 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
