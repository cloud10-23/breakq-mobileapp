import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HybridFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.hide) return Container();
            if (state.cart.cartItems?.isNotEmpty ?? false)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CartButton(
                    totalItems: state.cart.noOfProducts,
                    cartValue: state.cart.cartValue,
                  ),
                  ScanFloatingButtonExtended(),
                ],
              );
          }
          return ScanFloatingButtonExtended();
        });
  }
}

class CartButton extends StatelessWidget {
  CartButton({this.totalItems, this.cartValue});
  final int totalItems;
  final double cartValue;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => getIt.get<AppGlobals>().showCartPage(context),
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
            BoldTitle(title: '₹ ${(cartValue).toStringAsFixed(2)}'),
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
    return FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () => BarcodeScanner().scan(context),
        // onPressed: () => Navigator.pushNamed(context, Routes.scan),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Colors.blue[900],
                  Colors.blue[900],
                  // Color(0xFFFF4E50),
                  // Color(0xFFc31432),
                  // Color(0xFF8360c3),
                  // Color(0xFF1e130c),
                  // Colors.pink, Color(0xFFF9D423), Color(0xFF240b36), Color(0xFF2ebf91), Color(0xFF9a8478),
                ],
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 15.0,
                    color: Colors.blue[700],
                    spreadRadius: 0.0),
              ]),
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingL * 1.5, vertical: kPaddingM * 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(AssetImages.scan),
                color: Colors.white,
              ),
              SizedBox(width: kPaddingM),
              Text('Scan',
                  style: Theme.of(context).textTheme.bodyText1.bold.white),
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
          onPressed: () => BarcodeScanner().scan(context),
          // onPressed: () => Navigator.pushNamed(context, Routes.scan),
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
