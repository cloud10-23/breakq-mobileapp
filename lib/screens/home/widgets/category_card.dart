import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/utils/text_style.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.categoryTab});
  final CategoryTabModel categoryTab;
  @override
  Widget build(BuildContext context) {
    CategoryModel _category = categoryTab.category;
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, Routes.listing, arguments: _category),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Card(
          margin: EdgeInsets.all(1.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image(
                    // image: NetworkImage(_category.image),
                    image: AssetImage(AssetImages.productPlaceholder),
                    fit: BoxFit.fill),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(_category.title,
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
