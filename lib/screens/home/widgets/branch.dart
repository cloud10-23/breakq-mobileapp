import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BranchSelectorBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: "Select branch",
      isCaps: true,
      children: List.generate(4, (index) => _branch(index, context)),
    );
  }

  Widget _branch(int index, BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        primary: kBlack,
      ),
      icon: Icon(
        FontAwesome5Solid.store,
        size: 16.0,
      ),
      label: Expanded(
          child: Padding(
        padding: const EdgeInsets.only(left: kPaddingL),
        child: Text("Branch - ${index + 1}"),
      )),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
