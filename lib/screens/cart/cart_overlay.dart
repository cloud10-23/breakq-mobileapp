import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/widgets/bold_title.dart';
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
        child: ProfileScreen(),
      ),
      bottomSheet: CartBottomSheet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ScanFloatingButton(),
    );
  }
}

class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          if (state is CartLoaded) if (state.cartItems.cartItems?.isNotEmpty ??
              false)
            return BottomSheet(
              builder: (context) => Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(flex: 3),
                    Image(height: 25, image: AssetImage(AssetImages.cart)),
                    Spacer(),
                    CartTitle(title: 'Cart'),
                    CartTitle(title: '( ${state.totalItems} )'),
                    Spacer(flex: 5),
                    BoldTitle(title: '₹ 150.00'),
                    Spacer(),
                    CircleButton(),
                    Spacer(flex: 3),
                  ],
                ),
              ),
              onClosing: () {},
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kRoundedButtonRadius),
                    topRight: Radius.circular(kRoundedButtonRadius)),
              ),
            );
          return Container(height: 0);
        });
  }
}

class ScanFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: FloatingActionButton.extended(
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
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhite,
      radius: 15,
      child: Icon(Icons.arrow_drop_up_outlined),
    );
  }
}
