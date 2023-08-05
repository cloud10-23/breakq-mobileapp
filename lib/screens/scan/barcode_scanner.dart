import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScanner {
  String scanText;

  Future<void> scan(BuildContext context) async {
    try {
      scanText = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanText = "-1";
    }
    if (scanText != "-1") {
      // Loading Screen
      bool isDissmissed = false;
      showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Fetching product..."),
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()]),
                );
              },
              useRootNavigator: true)
          .then((value) {
        isDissmissed = true;
      });

      // Make a call to repository to get the product details:
      try {
        print("try scan");
        Product _product =
            await ProductsRepository().getScanProduct(productId: scanText);
        // If Loading Screen is not yet dismissed
        if (!isDissmissed) Navigator.of(context).pop();
        if (_product?.id != null)
          BlocProvider.of<CartBloc>(context)
              .add(RecentlyScannedEvent(product: _product));

        // Get the Product to display over here
        Navigator.of(context).pushNamed(Routes.product, arguments: _product);
      } catch (e) {
        print("catch scan");
        if (!isDissmissed) Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Oops!"),
                content: Text("Product not found"),
              );
            },
            useRootNavigator: true);
      }
    }
  }
}
