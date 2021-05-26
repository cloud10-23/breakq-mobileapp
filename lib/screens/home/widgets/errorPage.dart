import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter/material.dart';

class HomeErrorPage extends StatelessWidget {
  HomeErrorPage({this.tryAgain});
  final VoidCallback tryAgain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: kWhite),
        actionsIconTheme: IconThemeData(color: kWhite),
        backgroundColor: kBlue,
        title: Padding(
          padding: const EdgeInsets.only(top: kPaddingS),
          child: Row(
            children: [
              Spacer(),
              Image(
                image: AssetImage(AssetImages.bq_icon_alt),
                height: 30,
              ),
              Text(
                "BreakQ",
                style: Theme.of(context).textTheme.headline6.w700.white,
              ),
              Spacer(),
            ],
          ),
        ),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Text(
            "An Unexpected Error Occurred!",
            style: Theme.of(context).textTheme.headline5.w600.grey,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Expanded(
              flex: 5, child: Image(image: AssetImage(AssetImages.errors[1]))),
          Spacer(),
          Row(
            children: [
              Spacer(),
              ThemeButton(
                text: "Try Again",
                onPressed: tryAgain,
              ),
              Spacer(),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
