import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class QuickLinkButton extends StatelessWidget {
  QuickLinkButton({this.index, this.width});
  final int index;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (quickLinks[index]['link'] == 'SetBudget') {
          final _showSuccess =
              await getIt.get<AppGlobals>().showSetBudget(context);
          if (_showSuccess != null) {
            final _snackBar =
                SnackBar(content: Text("Budget has been set successfully!"));
            ScaffoldMessenger.maybeOf(context).showSnackBar(_snackBar);
          }
          return null;
        }
        return Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamed(quickLinks[index]['link']);
      },
      child: Container(
        constraints: BoxConstraints.tight(Size.fromWidth(width)),
        // margin: const EdgeInsets.only(
        //     top: 5.0, bottom: 5.0, right: 5.0), // for card shadow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 8,
              child: Icon(
                quickLinks[index]['icon'],
                color: kBlue,
              ),
            ),
            Spacer(flex: 2),
            Expanded(
              flex: 3,
              child: Text(
                quickLinks[index]['name'],
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .w500
                    .white
                    .fs10
                    .primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
