import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Cart {
  Cart({this.cartItems, this.cartValue, this.noOfProducts});
  List<CartItem> cartItems;
  int noOfProducts;
  double cartValue = 0.0;

  factory Cart.fromJson(List<dynamic> json) {
    return Cart(
      cartItems: json.map((product) => CartItem.fromJson(product)).toList(),
      noOfProducts: json?.length ?? 0,
    );
  }

  set setNoOfProducts(_noOfP) => noOfProducts = _noOfP;
  set setCartValue(_value) => cartValue = _value;

  void addProduct({@required Product product, int quantity = 1}) {
    bool _found = false;
    this.cartItems.forEach((cartItem) {
      if (cartItem.product.id == product.id) {
        cartItem.quantity += quantity;
        _found = true;
      }
    });
    if (!_found) cartItems.add(CartItem(product: product, quantity: quantity));
  }

  void bulkAddProducts({@required List<Product> products}) {
    products.forEach((product) {
      bool _found = false;
      this.cartItems.forEach((cartItem) {
        if (cartItem.product.id == product.id) {
          cartItem.quantity += 1;
          _found = true;
        }
      });
      if (!_found) cartItems.add(CartItem(product: product, quantity: 1));
    });
  }

  void reduceQOfProduct({@required Product product, int quantity = 1}) {
    List<CartItem> newCartItems = List();
    cartItems.forEach((cartItem) {
      if (cartItem.product.id == product.id) {
        if (cartItem.quantity > 1)
          newCartItems.add(cartItem..quantity -= quantity);
      } else
        newCartItems.add(cartItem);
    });
    this.cartItems = newCartItems;
  }

  void removeProduct({@required Product product}) {
    List<CartItem> newCartItems = List();
    cartItems.forEach((cartItem) {
      if (cartItem.product.id != product.id) newCartItems.add(cartItem);
    });
    this.cartItems = newCartItems;
  }
}

class CartItem {
  CartItem({this.product, this.quantity});
  final Product product;
  int quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json),
      quantity: 1,
    );
  }
}
