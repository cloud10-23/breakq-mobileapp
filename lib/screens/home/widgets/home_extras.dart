import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/branch.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GridImage extends StatelessWidget {
  GridImage({this.colIndex, this.rowIndex, this.height, this.width});
  final int colIndex;
  final int rowIndex;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.listing),
      child: Card(
        margin: EdgeInsets.all(1.0),
        child: Image(
            height: height,
            width: width,
            image: AssetImage((colIndex == null)
                ? AssetImages.topDeals(rowIndex)
                : AssetImages.topOffers(colIndex, rowIndex)),
            fit: BoxFit.fill),
      ),
    );
  }
}

class ExclProductsCard extends StatelessWidget {
  ExclProductsCard({this.index});
  final int index;

  Product getProduct(int index) {
    return Product(
      id: index + 10,
      image: AssetImages.maggi,
      oldPrice: 60,
      price: 40,
      quantity: '500 gm',
      title: 'Product ${index + 1}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: ProductListItem(
        viewType: ProductListItemViewType.grid,
        product: Product(
          id: index + 10,
          image: AssetImages.maggi,
          oldPrice: 60,
          price: 40,
          quantity: '500 gm',
          title: 'Product ${index + 1}',
        ),
        onProductAdd: () =>
            getIt.get<AppGlobals>().onProductAdd(getProduct(index), context),
        onProductRem: () =>
            getIt.get<AppGlobals>().onProductRed(getProduct(index), context),
        onProductDel: () =>
            getIt.get<AppGlobals>().onProductDel(getProduct(index), context),
        onProductPressed: () => getIt
            .get<AppGlobals>()
            .onProductPressed(getProduct(index), context),
      ),
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
