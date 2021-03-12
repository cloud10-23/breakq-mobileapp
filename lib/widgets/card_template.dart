import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/material.dart';

class CartHeading extends StatelessWidget {
  CartHeading(
      {@required this.title, @required this.children, this.isCaps = true});

  final String title;
  final List<Widget> children;
  final bool isCaps;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      margin: const EdgeInsets.all(kPaddingS),
      padding: EdgeInsets.all(kPaddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: BoldTitle(
                  title: (isCaps) ? title.toUpperCase() : title,
                  padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                  color: Colors.black54,
                  fw: FontWeight.w600,
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
              ),
              SizedBox(height: 5),
            ] +
            children,
      ),
    );
  }
}

class HomeHeading extends StatelessWidget {
  HomeHeading({@required this.image, @required this.children});

  final String image;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      margin: const EdgeInsets.all(kPaddingS),
      // padding: EdgeInsets.all(kPaddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
              Image(
                image: AssetImage(image),
              ),
              SizedBox(height: 5.0)
            ] +
            children,
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  HomeCard({@required this.image, @required this.children});

  final String image;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
