import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/utils/app_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      onTap: () => Navigator.pushNamed(context, Routes.listing,
          arguments: <CategoryModel, int>{_category: 0}),
      child: Card(
        margin: EdgeInsets.all(1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                cacheManager: AppCacheManager.instance,
                imageUrl: apiBaseFull + _category.image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(value: downloadProgress.progress)
                  ],
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AssetImages.productPlaceholder,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(_category.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.bold),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
