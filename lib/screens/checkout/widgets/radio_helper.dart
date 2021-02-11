import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CheckoutTypeOption extends StatelessWidget {
  CheckoutTypeOption(
      {@required this.index, @required this.session, this.onTap});

  final int index;
  final CheckoutSession session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    CheckoutType _type = CheckoutType.values[index];
    return Container(
      padding: const EdgeInsets.all(kPaddingM),
      constraints: BoxConstraints.tight(Size.fromHeight(80)),
      child: Card(
        child: InkWell(
          child: CustomPaint(
              painter: RadioCustomPainter(index: index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(kPaddingM),
                          child: Image(
                              image: AssetImage(
                                  AssetImages.checkoutImages(index))),
                        )),
                    Spacer(),
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CheckoutTypes.typeToString(_type),
                            style:
                                Theme.of(context).textTheme.subtitle2.fs10.w700,
                          ),
                          Text(CheckoutTypes.typeDescription(_type),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .fs10
                                  .w500
                                  .copyWith(
                                      color: Theme.of(context).hintColor)),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black45,
                    ),
                  ],
                ),
              )),
          onTap: onTap ?? () {},
        ),
      ),
    );
  }
}

class RadioCustomPainter extends CustomPainter {
  RadioCustomPainter({this.index});

  final int index;
  @override
  void paint(Canvas canvas, Size size) {
    //Apply the sub color to all first
    var paint = Paint()
      ..color = checkoutRadioColors[index]['sub']
      ..style = PaintingStyle.fill;

    var path = Path()
      ..addRect(Rect.fromCenter(
          height: size.height,
          width: size.width,
          center: size.center(Offset.zero)));
    canvas.drawPath(path, paint);

    //Top main part
    paint = Paint()
      ..color = checkoutRadioColors[index]['main']
      ..style = PaintingStyle.fill;

    path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.40));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
