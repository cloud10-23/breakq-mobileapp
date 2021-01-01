import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetImages.introScreen),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kCardRadius),
              topRight: Radius.circular(kCardRadius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                child: ThemeButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.signUp),
                    text: L10n.of(context).signInButtonRegister),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                child: ThemeButton(
                  alternate: true,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.signIn),
                  text: L10n.of(context).signInButton,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
