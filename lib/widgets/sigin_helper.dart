import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          if (social == Social.google)
            BlocProvider.of<AuthBloc>(context)
                .add(GoogleLoginRequestedAuthEvent());
          else
            BlocProvider.of<AuthBloc>(context)
                .add(FacebookLoginRequestedAuthEvent());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(flex: 1),
              Image(
                  image: (social == Social.google)
                      ? AssetImage("assets/images/google-icon.png")
                      : AssetImage("assets/images/facebook-icon.png"),
                  height: 35.0),
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  (social == Social.google)
                      ? 'Sign in with Google'
                      : 'Sign in with Facebook',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
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
