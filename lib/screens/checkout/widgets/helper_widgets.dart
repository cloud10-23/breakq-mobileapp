import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/checkout/widgets/cart_products_listing.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:breakq/utils/text_style.dart';

class ShowQRModule extends StatelessWidget {
  ShowQRModule({@required this.billNo});
  final String billNo;

  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Show QR Code',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Text(
            "${getIt.get<AppGlobals>().user.displayName}",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: kPaddingS),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Text(
            "${getIt.get<AppGlobals>().user.phoneNumber}",
            style: Theme.of(context).textTheme.subtitle1.w700.number.grey,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: kPaddingL),
        Center(
          child: QrImage(
            data: billNo ?? 'ERROR',
            version: QrVersions.auto,
            backgroundColor: kWhite,
            size: 100,
            gapless: false,
            // embeddedImage: AssetImage(AssetImages.icon),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(30, 30),
            ),
          ),
        ),
        SizedBox(height: kPaddingM),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Text(
            "Order No: ${billNo ?? 123445678990}",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: kPaddingM),
      ],
    );
  }
}

class CheckoutTypeModule extends StatelessWidget {
  CheckoutTypeModule({@required this.index, this.isReadOnly = false});
  final int index;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Checkout Type',
      children: [
        Padding(
            padding: const EdgeInsets.only(left: kPaddingM),
            child: CheckoutTypeOption(
                index: index,
                onTap: (!isReadOnly)
                    ? () {
                        showCheckoutTypeSelector(context);
                      }
                    : null)),
      ],
    );
  }

  Future<void> showCheckoutTypeSelector(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => CheckoutTypeSelector(onTap: (index) {
        BlocProvider.of<CheckoutBloc>(context)
            .add(CheckoutTypeSelectedChEvent(type: CheckoutType.values[index]));
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
    );
  }
}

class CheckoutTypeSelector extends StatelessWidget {
  CheckoutTypeSelector({this.onTap});
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: "Choose a Checkout Type",
      children: List.generate(
        3,
        (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
            child: CheckoutTypeOption(
              index: index,
              onTap: () {
                Navigator.of(context).pop();
                onTap(index);
              },
            )),
      ),
    );
  }
}

class BranchModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = getIt.get<AppGlobals>().selectedStore;
    return CartHeading(
      title: 'Branch',
      children: [
        ListTile(
          leading: Icon(
            FontAwesome5Solid.store,
            size: 18.0,
            color: kBlack,
          ),
          minVerticalPadding: 10.0,
          title: Text(store.branchName,
              style: Theme.of(context).textTheme.bodyText1.w700),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: kPaddingS),
            child: Text(
                "${store.branchName}, " + //${store[index].branchStore}, " +
                    "${store.city}, ${store.state}," +
                    " ${store.country}, ${store.pinCode}",
                style: Theme.of(context).textTheme.caption.w600),
          ),
        ),
      ],
    );
  }
}

class CartProductsModule extends StatelessWidget {
  CartProductsModule({@required this.products});
  final Map<Product, int> products;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Products',
      children: [
        CartProductsReadOnly(
          products: products,
        )
      ],
    );
  }
}

class StepShowModule extends StatelessWidget {
  StepShowModule({@required this.steps, @required this.currentStep});
  final List<Step> steps;
  final int currentStep;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: kBlue900),
      child: Container(
        constraints: BoxConstraints(maxHeight: 200),
        child: CustomStepper(currentStep: currentStep, steps: steps),
      ),
    );
  }
}

class AdsModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        autoplay: true,
        duration: 500,
        autoplayDelay: 1000,
        itemBuilder: (context, index) => Image(
          image: AssetImage(AssetImages.ads(index)),
        ),
        itemCount: 2,
      ),
    );
  }
}

class FooterModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50);
  }
}
