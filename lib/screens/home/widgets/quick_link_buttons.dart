import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class QuickLinkButton extends StatelessWidget {
  QuickLinkButton({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(1.0), // for card shadow
      padding: const EdgeInsets.only(right: kPaddingS),
      child: Card(
        color: kPrimaryColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: InkWell(
          onTap: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(quickLinks[index]['link'] ?? Routes.cart),
          child: CustomPaint(
            painter: RadioCustomPainter(index: index % 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingS),
              child: Row(
                children: [
                  Spacer(),
                  Flexible(
                    flex: 4,
                    child: Image(image: AssetImage(quickLinks[index]['image'])),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 6,
                    child: Text(
                      quickLinks[index]['name'],
                      style: Theme.of(context).textTheme.caption.bold.fs10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
