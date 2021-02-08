import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class CheckoutTypeRadio extends StatelessWidget {
  CheckoutTypeRadio({@required this.index, @required this.session});

  final int index;
  final CheckoutSession session;

  @override
  Widget build(BuildContext context) {
    CheckoutType _type = CheckoutType.values[index];
    int _selectedIndex = session.currentStep.checkoutType.index;
    return Padding(
      padding: const EdgeInsets.all(kPaddingM),
      child: Card(
        child: InkWell(
          child: CustomPaint(
            painter: RadioCustomPainter(index: index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingM, vertical: kPaddingL),
              child: Row(
                children: [
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    groupValue: _selectedIndex,
                    value: index,
                    activeColor: Colors.blue[900],
                    onChanged: (value) => BlocProvider.of<CheckoutBloc>(context)
                        .add(CheckoutTypeSelectedChEvent(type: _type)),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          CheckoutTypes.typeToString(_type),
                          style: Theme.of(context).textTheme.subtitle2.w500,
                        ),
                        SizedBox(height: kPaddingM),
                        Text(CheckoutTypes.typeDescription(_type),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .w300
                                .copyWith(color: Theme.of(context).hintColor)),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
                  Flexible(
                      flex: 3,
                      child: Image(
                          image:
                              AssetImage(AssetImages.checkoutImages(index)))),
                ],
              ),
            ),
          ),
          onTap: () {
            BlocProvider.of<CheckoutBloc>(context)
                .add(CheckoutTypeSelectedChEvent(type: _type));
          },
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
