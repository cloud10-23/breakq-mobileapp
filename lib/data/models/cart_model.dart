import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Cart {
  Cart({this.cartItems, this.cartValue, this.noOfProducts});
  Map<Product, int> cartItems;
  int noOfProducts;
  double cartValue = 0.0;
  double orgCartValue = 0.0;

  factory Cart.fromJson(List<dynamic> json) {
    return Cart(
      cartItems: json
          .map((product) => {Product.fromJson(product): 1})
          .reduce((value, element) {
        value.addAll(element);
        return value;
      }),
      noOfProducts: json?.length ?? 0,
    );
  }

  set setNoOfProducts(_noOfP) => noOfProducts = _noOfP;
  set setCartValue(_value) => cartValue = _value;
  set setorgCartValue(_value) => orgCartValue = _value;

  void addProduct({@required Product product, int quantity = 1}) {
    if (cartItems.containsKey(product)) {
      cartItems[product] += quantity;
    } else
      cartItems[product] = quantity;
  }

  void bulkAddProducts({@required Map<Product, int> newCartItems}) {
    this.cartItems.addAll(newCartItems);
  }

  void reduceQOfProduct({@required Product product, int quantity = 1}) {
    if (this.cartItems[product] <= 1 || this.cartItems[product] < quantity)
      this.cartItems.remove(product);
    else
      this.cartItems[product] -= quantity;
  }

  void removeProduct({@required Product product}) {
    this.cartItems.remove(product);
  }
}
