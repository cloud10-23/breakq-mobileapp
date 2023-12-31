import 'package:breakq/widgets/photo_gallery_header.dart';
import 'package:flutter/material.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        PhotoGalleryScreenHeader(
          name: product.title,
        ),
        // if (product.ratings > 0)
        //   InkWell(
        //     onTap: () {
        //       Navigator.pushNamed(context, Routes.productReviews,
        //           arguments: product);
        //     },
        //     child: Padding(
        //       padding:
        //           const EdgeInsets.only(bottom: kPaddingM, left: kPaddingM),
        //       child: Container(
        //         width: 96,
        //         height: 64,
        //         decoration: const BoxDecoration(
        //           color: Colors.black54,
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(kFormFieldsRadius),
        //           ),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Text(
        //               product.rate.toString(),
        //               style: Theme.of(context).textTheme.headline6.w800.white,
        //             ),
        //             const Padding(padding: EdgeInsets.only(top: 4)),
        //             Text(
        //               L10n.of(context)
        //                   .productTotalReviews(product.ratings.toString()),
        //               style: Theme.of(context).textTheme.bodyText2.white,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
