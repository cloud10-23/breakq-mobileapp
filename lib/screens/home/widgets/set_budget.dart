import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

class SetBudgetBottomSheet extends StatefulWidget {
  @override
  _SetBudgetBottomSheetState createState() => _SetBudgetBottomSheetState();
}

class _SetBudgetBottomSheetState extends State<SetBudgetBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: "Set Budget",
      isCaps: true,
      children: [
        TextField(
          autofocus: true,
          cursorColor: kBlue,
          style: Theme.of(context).textTheme.headline3.black,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              FontAwesome.rupee,
              size: 32,
              color: kBlue,
            ),
            focusColor: kBlue,
            suffix: IconButton(
              icon: Icon(
                Feather.check_circle,
                color: kBlue,
                size: 25,
              ),
              onPressed: () => _onSubmit(""),
            ),
          ),
          onSubmitted: (value) => _onSubmit(value),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingL),
          child: Text(
            "Choose an amount for your budget. We'll let you know when" +
                " you are getting close to reaching your budget",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  void _onSubmit(String value) {
    Navigator.of(context).pop();
  }
}
