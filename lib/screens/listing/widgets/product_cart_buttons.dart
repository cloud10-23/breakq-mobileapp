import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';

class ProductAddRemButtons extends StatelessWidget {
  ProductAddRemButtons({this.onAdd, this.onDel, this.onRem, this.qty});
  final Function onAdd;
  final Function onRem;
  final Function onDel;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.0,
          child: FlatButton(
            onPressed: onRem,
            child: Icon(Icons.remove, color: kBlack),
          ),
        ),
        Expanded(
          child: FlatButton(
              onPressed: onAdd,
              color: kPrimaryColor,
              child: Text(qty.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: kBlack))),
        ),
      ],
    );
  }
}
