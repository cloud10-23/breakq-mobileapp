import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/branch.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:breakq/utils/app_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GridImage extends StatelessWidget {
  GridImage({this.image, this.width, this.onPressed});
  final String image;
  final double width;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.all(1.0),
        child: CachedNetworkImage(
          // cacheManager: AppCacheManager.instance,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: downloadProgress.progress)
            ],
          ),
          errorWidget: (context, url, error) => Image.asset(
            AssetImages.productPlaceholder,
            height: width,
            width: width,
            fit: BoxFit.fill,
          ),
          height: width,
          width: width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ExclProductsCard extends StatelessWidget {
  ExclProductsCard({@required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: ProductListItem(
        viewType: ProductListItemViewType.grid,
        product: product,
        onProductAdd: () =>
            getIt.get<AppGlobals>().onProductAdd(product, context),
        onProductRem: () =>
            getIt.get<AppGlobals>().onProductRed(product, context),
        onProductDel: () =>
            getIt.get<AppGlobals>().onProductDel(product, context),
        onProductPressed: () =>
            getIt.get<AppGlobals>().onProductPressed(product, context),
      ),
    );
  }
}

class NotificationBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          AntDesign.bells,
          size: 20.0,
        ),
        onPressed: () {});
  }
}

class SelectBranchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Entypo.location_pin,
        size: 20.0,
      ),
      onPressed: () {
        // Open Branch Chooser
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          clipBehavior: Clip.antiAlias,
          isDismissible: true,
          builder: (context) => BranchSelectorBottomSheet(),
        );
      },
    );
  }
}

class SelectBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(
        bottom: kPaddingM,
      ),
      height: 40,
      child: Card(
        color: getIt.get<AppGlobals>().isPlatformBrightnessDark
            ? Theme.of(context).accentColor
            : kBlack,
        margin: const EdgeInsets.all(0),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(kBoxDecorationRadius),
        //   side: BorderSide(width: 0.5, color: Colors.),
        // ),
        child: TextButton(
          // color: kPrimaryAccentColor,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBoxDecorationRadius / 2)),
          ),
          onPressed: () {
            // Open Branch Chooser
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              clipBehavior: Clip.antiAlias,
              isDismissible: true,
              builder: (context) => BranchSelectorBottomSheet(),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesome.building_o,
                color: kWhite,
                size: 16,
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: Text("Select Branch",
                    style: Theme.of(context).textTheme.caption.fs8.w800.white),
              ),
              Icon(
                AntDesign.caretdown,
                color: kWhite,
                size: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class BranchDropDown extends StatefulWidget {
  const BranchDropDown({Key key}) : super(key: key);

  @override
  _BranchDropDownState createState() => _BranchDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BranchDropDownState extends State<BranchDropDown> {
  String dropdownValue = 'T-Nagar Branch';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      // itemHeight: 50,
      elevation: 2,
      icon: Container(),
      style: getIt.get<AppGlobals>().captionStyle(context),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'T-Nagar Branch',
        'MV-Nagar Branch',
        'RT-Nagar Branch',
        'SK-Nagar Branch'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
