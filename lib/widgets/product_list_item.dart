import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/string.dart';
import 'package:sprintf/sprintf.dart';

enum ProductListItemViewType { grid, search, list, block, map }

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key key,
    this.product,
    this.viewType,
    this.wordToStyle = '',
    this.showDistance = true,
    this.showFavoriteButton = false,
    this.isFavorited = false,
    this.onFavoriteButtonPressed,
  }) : super(key: key);

  final ProductModel product;
  final ProductListItemViewType viewType;
  final String wordToStyle;
  final bool showDistance;
  final bool showFavoriteButton;
  final bool isFavorited;
  final VoidCallback onFavoriteButtonPressed;

  // void _showLocationScreen(BuildContext context) {
  //   Navigator.pushNamed(context, Routes.location, arguments: product.id);
  // }

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case ProductListItemViewType.block:
      case ProductListItemViewType.map:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            height: 290,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
              // border: Border.all(
              //   color: Theme.of(context).dividerColor,
              //   width: 1,
              // ),
            ),
            child: InkWell(
              onTap: () {
                // _showLocationScreen(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        height:
                            viewType == ProductListItemViewType.map ? 160 : 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(product.image),
                            // image: NetworkImage(product.image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(kBoxDecorationRadius),
                            topRight: Radius.circular(kBoxDecorationRadius),
                          ),
                        ),
                      ),
                      if (showFavoriteButton)
                        IconButton(
                          icon: Icon(isFavorited
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: kPrimaryColor,
                          onPressed: onFavoriteButtonPressed ?? () {},
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingS,
                        right: kPaddingS,
                        top: kPaddingS,
                        bottom: kPaddingS / 2),
                    child: Text(
                      product.title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1.fs18.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingS,
                        right: kPaddingS,
                        bottom: kPaddingS / 2),
                    child: Text(
                      sprintf('%s', <String>[product.quantity]),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Theme.of(context).hintColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingS, right: kPaddingS),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Text(
                            "₹",
                            style: Theme.of(context).textTheme.bodyText2.bold,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                product.price.toString(),
                                style:
                                    Theme.of(context).textTheme.subtitle1.bold,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case ProductListItemViewType.grid:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
              // border: Border.all(
              //   color: Theme.of(context).dividerColor,
              //   width: 1,
              // ),
            ),
            child: Column(
              children: [
                InkWell(
                  splashColor: kPrimaryColor,
                  onTap: () {
                    // _showLocationScreen(context);
                  },
                  onLongPress: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(product.image),
                            // image: NetworkImage(product.image),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(kBoxDecorationRadius),
                            topRight: Radius.circular(kBoxDecorationRadius),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kPaddingS, left: kPaddingS, right: kPaddingS),
                        child: Text(
                          product.title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyText2.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPaddingS, right: kPaddingS, top: 2),
                        child: Text(
                          product.quantity,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Theme.of(context).hintColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPaddingS,
                            right: kPaddingS,
                            bottom: kPaddingS,
                            top: 2),
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Text(
                                "₹",
                                style:
                                    Theme.of(context).textTheme.bodyText2.bold,
                              ),
                            ),
                            Text(
                              product.price.toString(),
                              style: Theme.of(context).textTheme.bodyText2.bold,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('+ icon pressed!');
                  },
                  color: kPrimaryColor,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
        break;

      case ProductListItemViewType.list:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
              // border: Border.all(
              //   color: Theme.of(context).dividerColor,
              //   width: 1,
              // ),
            ),
            child: InkWell(
              onTap: () {
                // _showLocationScreen(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        // image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kBoxDecorationRadius),
                        bottomLeft: Radius.circular(kBoxDecorationRadius),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: kPaddingS,
                          bottom: kPaddingS,
                          left: kPaddingS,
                          right: kPaddingS),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.title,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.subtitle1.w600,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 2)),
                          Text(
                            sprintf('%s', <String>[product.quantity]),
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 2, right: kPaddingS),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 2),
                                  child: Text(
                                    "₹",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    product.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        break;

      case ProductListItemViewType.search:
        return InkWell(
          onTap: () {
            // _showLocationScreen(context);
          },
          child: Container(
            decoration: BoxDecoration(
              //color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: kPaddingS),
                  child: Icon(
                    Icons.location_on,
                    color: Theme.of(context).disabledColor,
                    size: 36,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingM, bottom: kPaddingM),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (wordToStyle.isEmpty)
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          else
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.subtitle1,
                                children: product.title.getSpans(
                                  matchWord: wordToStyle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          Text(
                            sprintf('%s', <String>[product.quantity]),
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).hintColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
        break;

      default:
        return Container();
    }
  }
}
