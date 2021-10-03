import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter/material.dart';

class OrderError extends StatelessWidget {
  const OrderError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        leading: BackButtonCircle(),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Image.asset(
            AssetImages.errors[1],
            height: 200,
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(kPaddingM),
            child: Text(
              'There was an Unexpected error! Sorry for the inconvenience!',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .bold
                  .fs18
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
