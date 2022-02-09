import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Cart {
  Cart({this.cartItems, this.cartValue, this.noOfProducts = 0});
  Map<Product, int> cartItems;
  int noOfProducts;
  Price cartValue;

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

  factory Cart.fromCartApi(CartAPI api) {
    List<CartProduct> cartProducts = api.products;
    int _noOfProducts = 0;
    double _cartValue = 0.0;
    double _orgCartValue = 0.0;
    if (cartProducts == null || cartProducts.isEmpty) {
      return Cart(cartItems: {}, noOfProducts: _noOfProducts);
    }

    return Cart(
      cartItems: cartProducts.map((cartProduct) {
        _noOfProducts += cartProduct.qty;
        _cartValue += cartProduct.qty * cartProduct.product.salePrice;
        _orgCartValue += cartProduct.qty * cartProduct.product.maxPrice;
        return {cartProduct.product: cartProduct.qty};
      }).reduce((value, element) {
        value.addAll(element);
        return value;
      }),
      noOfProducts: _noOfProducts,
      cartValue: Price.addPrice(api.priceDetails, _cartValue),
    );
  }

  set setNoOfProducts(_noOfP) => noOfProducts = _noOfP;

  void setCartValue(_orgPrice, _price) =>
      cartValue = Price.calc(_orgPrice, _price);

  int addProduct({@required Product product, int quantity = 1}) {
    if (cartItems.containsKey(product)) {
      cartItems[product] += quantity;
    } else
      cartItems[product] = quantity;
    cartValue =
        Price.addProduct(cartValue ?? Price(), product.salePrice * quantity);
    noOfProducts += quantity;
    return cartItems[product];
  }

  void bulkAddProducts({@required Map<Product, int> newCartItems}) {
    this.cartItems.addAll(newCartItems);
  }

  int reduceQOfProduct({@required Product product, int quantity = 1}) {
    if (this.cartItems[product] <= 1 || this.cartItems[product] < quantity) {
      this.cartItems.remove(product);
      return 0;
    }
    this.cartItems[product] -= quantity;
    cartValue =
        Price.addProduct(cartValue ?? Price(), -product.salePrice * quantity);
    noOfProducts -= quantity;
    return this.cartItems[product];
  }

  void removeProduct({@required Product product}) {
    final qty = this.cartItems.remove(product);
    cartValue =
        Price.addProduct(cartValue ?? Price(), -product.salePrice * qty);
    noOfProducts -= qty;
  }
}
