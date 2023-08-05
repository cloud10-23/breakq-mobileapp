import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class GridAddButton extends StatelessWidget {
  GridAddButton({this.onProductAdd});
  final Function onProductAdd;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onProductAdd();
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: kBlue
        ),
        margin: EdgeInsets.all(kPaddingM),
        child: Icon(Icons.add, color: kWhite),
      ),
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
            child: InkWell(
              onTap: onAdd,
              child: Container(
                margin: const EdgeInsets.all(1),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      qty.toString(),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .fs12
                          .copyWith(
                              color: kWhite, fontFamily: kNumberFontFamily),
                    ),
                  ],
                ),
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
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kBlue,
            fixedSize: Size.fromHeight(30),
            shape: ContinuousRectangleBorder(
                side: BorderSide(color: kWhite),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          onPressed: onProductAdd,
          child: Row(
            children: [
              Icon(Icons.add, color: kWhite),
              SizedBox(width: 10.0),
              Text('Add Item',
                  style: Theme.of(context).textTheme.caption.white.w700),
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
            child: TextButton(
              onPressed: onRem,
              child: Icon(Icons.remove, color: kBlack, size: 15.0),
            ),
          ),
          Expanded(
            child: Container(
                child: Text(qty.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline6.fs16.copyWith(
                        color: kBlack, fontFamily: kNumberFontFamily))),
          ),
          Container(
            width: 35,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                )),
                backgroundColor: kBlue,
              ),
              onPressed: onAdd,
              child: Icon(Icons.add, color: kWhite, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class ListAddRemButtonSmall extends StatelessWidget {
  ListAddRemButtonSmall({this.onAdd, this.onRem, this.qty});
  final Function onAdd;
  final Function onRem;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 80,
      child: Row(
        children: [
          Container(
            width: 25,
            // clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: onRem,
              child: Icon(Icons.remove, color: kBlack, size: 12.0),
            ),
          ),
          Expanded(
            child: Container(
                child: Text(qty.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.fs10.copyWith(
                        color: kBlack, fontFamily: kNumberFontFamily))),
          ),
          Container(
            width: 25,
            child: TextButton(
              style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              )),
              backgroundColor: kBlue,
              ),
              onPressed: onAdd,
              child: Icon(Icons.add, color: kWhite, size: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetCartButtonCircleIcon extends StatelessWidget {
  ResetCartButtonCircleIcon({this.onProductDel});
  final Function onProductDel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhite,
      radius: 16,
      child: IconButton(
        icon: Icon(Icons.delete),
        color: kBlue,
        iconSize: 16,
        onPressed: onProductDel ?? () {},
      ),
    );
  }
}

class ResetCartButtonText extends StatelessWidget {
  ResetCartButtonText({this.onProductDel, this.title});
  final Function onProductDel;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: EdgeInsets.all(kPaddingS),
      child: TextButton(
              style: TextButton.styleFrom(
          padding: EdgeInsets.all(kPaddingS),
          backgroundColor: kWhite,
          fixedSize: Size.fromHeight(15),
          shape: ContinuousRectangleBorder(
              side: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
          onPressed: onProductDel,
          child: Row(
            children: [
              Icon(Icons.delete, color: kBlackAccent, size: 15),
              SizedBox(width: 10.0),
              Text(title ?? 'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .w600
                      .fs10
                      .copyWith(color: kBlack)),
            ],
          )),
    );
  }
}
