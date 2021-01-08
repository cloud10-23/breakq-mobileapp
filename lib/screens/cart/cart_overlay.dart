import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartNavigation extends StatelessWidget {
  CartNavigation({this.homeScreen, this.navigatorKey});
  final Widget homeScreen;
  final GlobalKey<NavigatorState> navigatorKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNavigator(
        homeScreen: homeScreen,
        navigatorKey: navigatorKey,
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      floatingActionButton: HybridFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class HybridFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          if (state is CartLoaded) if (state.cartItems.cartItems?.isNotEmpty ??
              false)
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ScanFloatingButton(),
                CartButton(totalItems: state.totalItems),
              ],
            );
          return ScanFloatingButtonExtended();
        });
  }
}

class CartButton extends StatelessWidget {
  CartButton({this.totalItems});
  final int totalItems;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: CartBottomSheet()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          clipBehavior: Clip.antiAlias,
          isDismissible: true,
        );
      },
      heroTag: null,
      label: Container(
        width: 160.0,
        child: Row(
          children: [
            Spacer(flex: 3),
            Image(height: 25, image: AssetImage(AssetImages.cart)),
            Spacer(),
            BoldTitle(title: '( $totalItems )'),
            Spacer(),
            BoldTitle(title: '₹ 150.00'),
            // Spacer(),
            // CircleButton(),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class ScanFloatingButtonExtended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Colors.black,
        onPressed: () {},
        label: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Row(
            children: [
              Text('Scan',
                  style: Theme.of(context).textTheme.bodyText1.bold.white),
              SizedBox(width: kPaddingM),
              Image(
                image: AssetImage(AssetImages.scan),
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}

class ScanFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.black,
          onPressed: () {},
          child: Image(
            image: AssetImage(AssetImages.scan),
            color: Colors.white,
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhite,
      radius: 12,
      child: Icon(Icons.arrow_drop_up_outlined),
    );
  }
}
