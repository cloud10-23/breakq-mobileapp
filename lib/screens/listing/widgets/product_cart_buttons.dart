import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class GridAddButton extends StatelessWidget {
  GridAddButton({this.onProductAdd});
  final Function onProductAdd;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.all(kPaddingM),
      child: FlatButton(
          color: kWhite,
          onPressed: onProductAdd,
          child: Icon(Icons.add, color: kBlackAccent)),
    );
  }
}

class GridAddRemButtons extends StatelessWidget {
  GridAddRemButtons({this.onAdd, this.onRem, this.qty});
  final Function onAdd;
  final Function onRem;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.all(kPaddingM),
      child: Row(
        children: [
          Container(
            width: 35,
            child: IconButton(
              onPressed: onRem,
              iconSize: 15,
              icon: Icon(Icons.remove, color: kBlack),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: onAdd,
              color: kPrimaryColor,
              child: Text(
                qty.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .fs16
                    .copyWith(color: kBlack, fontFamily: kNumberFontFamily),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListAddItemButton extends StatelessWidget {
  ListAddItemButton({this.onProductAdd});
  final Function onProductAdd;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.only(right: kPaddingM),
      child: FlatButton(
          color: kWhite,
          onPressed: onProductAdd,
          height: 30,
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Row(
            children: [
              Icon(Icons.add, color: kBlackAccent),
              SizedBox(width: 10.0),
              Text('Add Item',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: kBlack)),
            ],
          )),
    );
  }
}

class ListAddRemButtons extends StatelessWidget {
  ListAddRemButtons({this.onAdd, this.onRem, this.qty});
  final Function onAdd;
  final Function onRem;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 110,
      margin: EdgeInsets.all(kPaddingM),
      child: Row(
        children: [
          Container(
            width: 35,
            // clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              ),
            ),
            child: FlatButton(
              onPressed: onRem,
              child: Icon(Icons.remove, color: kBlack, size: 15.0),
            ),
          ),
          Expanded(
            child: Container(
                child: Text(qty.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.fs16.copyWith(
                        color: kBlack, fontFamily: kNumberFontFamily))),
          ),
          Container(
            width: 35,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              )),
              color: kPrimaryColor,
              onPressed: onAdd,
              child: Icon(Icons.add, color: kBlack, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetCartButton extends StatelessWidget {
  ResetCartButton({this.onProductDel});
  final Function onProductDel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhite,
      radius: 18,
      child: IconButton(
        icon: Icon(Icons.delete),
        color: kBlack,
        iconSize: 18,
        onPressed: onProductDel ?? () {},
      ),
    );
  }
}
