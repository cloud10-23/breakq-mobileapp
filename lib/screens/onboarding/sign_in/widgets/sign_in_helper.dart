import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ShowSelectedCountry extends StatelessWidget {
  final VoidCallback onPressed;
  final Country country;

  const ShowSelectedCountry({Key key, this.onPressed, this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Text(
            ' ${country.flag}  ${country.dialCode}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          // Was in a Row : Icon(Icons.arrow_drop_down, size: 24.0)
        ),
      ),
    );
  }
}

enum Social { google, facebook }

class SignInSocialButton extends StatelessWidget {
  SignInSocialButton({this.social = Social.google});
  final Social social;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSocialButtonHeight,
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          side: BorderSide(color: Colors.grey),
          elevation: 0.0,
          backgroundColor:
              (social == Social.google) ? kWhite : Color(0xFF394BAD),
          // splashColor: Colors.grey,
        ),
        onPressed: () {
          if (social == Social.google)
            BlocProvider.of<AuthBloc>(context)
                .add(GoogleLoginRequestedAuthEvent());
          else
            BlocProvider.of<AuthBloc>(context)
                .add(FacebookLoginRequestedAuthEvent());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(flex: 1),
              (social == Social.google)
                  ? Image(
                      image: AssetImage("assets/images/google-icon.png"),
                      height: 18.0)
                  : Icon(
                      FontAwesome5Brands.facebook_f,
                      size: 18.0,
                      color: kWhite,
                    ),
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  (social == Social.google) ? 'Google' : 'Facebook',
                  style: (social == Social.google)
                      ? Theme.of(context).textTheme.caption.w600
                      : Theme.of(context).textTheme.caption.w600.white,
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpSocialButton extends StatelessWidget {
  SignUpSocialButton({this.social = Social.google});
  final Social social;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSocialButtonHeight,
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          side: BorderSide(color: Colors.grey),
          elevation: 0.0,
          backgroundColor:
              (social == Social.google) ? kWhite : Color(0xFF394BAD),
          // splashColor: Colors.grey,
        ),
        onPressed: () {
          if (social == Social.google)
            BlocProvider.of<AuthBloc>(context)
                .add(GoogleLoginRequestedAuthEvent());
          else
            BlocProvider.of<AuthBloc>(context)
                .add(FacebookLoginRequestedAuthEvent());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(flex: 1),
              (social == Social.google)
                  ? Image(
                      image: AssetImage("assets/images/google-icon.png"),
                      height: 25.0)
                  : Icon(
                      FontAwesome5Brands.facebook_f,
                      size: 25.0,
                      color: kWhite,
                    ),
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  (social == Social.google)
                      ? 'Sign up with Google'
                      : 'Sign up with Facebook',
                  style: (social == Social.google)
                      ? Theme.of(context).textTheme.subtitle2.w600
                      : Theme.of(context).textTheme.subtitle2.w600.white,
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
