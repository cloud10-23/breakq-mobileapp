import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartModel {
  CartModel({this.cartItems});

  void addProduct({@required ProductModel product, int quantity = 1}) {
    bool _found = false;
    cartItems.map((cartItem) {
      if (cartItem.product == product) {
        cartItem.quantity += quantity;
        _found = true;
        return;
      }
    });
    if (!_found) cartItems.add(CartItem(product: product, quantity: quantity));
  }

  void removeProduct({@required ProductModel product, int quantity = 1}) {
    cartItems.map((cartItem) {
      if (cartItem.product == product) {
        if (quantity == null || cartItem.quantity <= 1)
          cartItems.remove(cartItem);
        else
          cartItem.quantity -= quantity;
        return;
      }
    });
  }
  // factory CartModel.fromJson(Map<String, dynamic> json) {
  //   return CartModel(
  //   );
  // }

  List<CartItem> cartItems;
}

class CartItem {
  CartItem({this.product, this.quantity});
  final ProductModel product;
  int quantity;
}
