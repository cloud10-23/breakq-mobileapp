import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

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
    List<String> cities = [
      "T. Nagar",
      "Teynampet",
      "Tharamani",
      " Thuraipakkam",
      "Tirusulam"
    ];
    return ListTile(
      leading: Icon(
        FontAwesome5Solid.store,
        size: 18.0,
        color: kBlack,
      ),
      minVerticalPadding: 10.0,
      title: Text("Branch - ${index + 1}",
          style: Theme.of(context).textTheme.bodyText1.w700),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: kPaddingS),
        child: Text(
            "No ${index * 2 + 1}${index * 3 + 1}${index % 2 + 2},  ${(index + 1 * 9) % 7}th cross, ${cities[index]} Branch, Chennai - 5600${(index * 237) % 50}",
            style: Theme.of(context).textTheme.caption.w600),
      ),
      trailing: Icon(
        Feather.arrow_right_circle,
        size: 16.0,
        color: kBlack,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
    // return TextButton.icon(
    //   style: TextButton.styleFrom(
    //     primary: kBlack,
    //   ),
    //   icon: Icon(
    //     FontAwesome5Solid.store,
    //     size: 16.0,
    //   ),
    //   label: Expanded(
    //       child: Padding(
    //     padding: const EdgeInsets.only(left: kPaddingL),
    //     child: Text("Branch - ${index + 1}"),
    //   )),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );
  }
}
