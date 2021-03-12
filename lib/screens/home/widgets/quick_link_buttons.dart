import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class QuickLinkButton extends StatelessWidget {
  QuickLinkButton({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(
          top: 5.0, bottom: 5.0, right: 5.0), // for card shadow
      padding: const EdgeInsets.only(right: kPaddingS),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25.0), boxShadow: [
        BoxShadow(blurRadius: 6.0, color: kBlue700, spreadRadius: 0.0),
      ]),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: kBlue900,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25), // Radius.zero,
          topRight: Radius.circular(25), //Radius.zero,
        )),
        child: InkWell(
          onTap: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(quickLinks[index]['link']),
          child: Padding(
            padding: EdgeInsets
                .zero, //const EdgeInsets.symmetric(horizontal: kPaddingS),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(quickLinks[index]['image']),
                ),
                Spacer(),
                Expanded(
                  flex: 8,
                  child: Text(
                    quickLinks[index]['name'],
                    style: Theme.of(context).textTheme.caption.w500.white.fs10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
