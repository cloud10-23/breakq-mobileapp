import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/utils/text_style.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CustomNavigatorRoutes.listing),
      child: Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
        child: Card(
          // shape: RoundedRectangleBorder(),
          clipBehavior: Clip.antiAlias,
          // shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(25.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image(
                    image: AssetImage(categories[index]['image']),
                    fit: BoxFit.fill),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(categories[index]['name'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.bold),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
