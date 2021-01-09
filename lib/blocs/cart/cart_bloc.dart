import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitCartEvent) {
      yield* _mapInitCartEventToState(event);
    } else if (event is LoadCartEvent) {
      yield* _mapLoadCartEventToState(event);
    } else if (event is AddPToCartEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is ReduceQOfPCartEvent) {
      yield* _mapReduceQEventToState(event);
    } else if (event is RemovePFromCartEvent) {
      yield* _mapRemoveEventToState(event);
    }
  }

  Stream<CartState> _mapInitCartEventToState(InitCartEvent event) async* {
    yield CartLoaded(cart: Cart(cartItems: List<CartItem>()));
  }

  Stream<CartState> _mapLoadCartEventToState(LoadCartEvent event) async* {
    //Total items:
    int _noOfProducts = 0;
    double _cartValue = 0.0;
    event.cartItems.cartItems.forEach((item) {
      _noOfProducts += item.quantity;
      _cartValue += item.quantity * item.product.price;
    });

    event.cartItems.setNoOfProducts = _noOfProducts;
    event.cartItems.setCartValue = _cartValue;

    yield CartLoaded(cart: event.cartItems);
  }

  Stream<CartState> _mapAddEventToState(AddPToCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Add the product to cart here
    cartItems.addProduct(product: event.product);

    add(LoadCartEvent(cartItems: cartItems));
  }

  Stream<CartState> _mapReduceQEventToState(ReduceQOfPCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Remove the product from cart here
    cartItems.reduceQOfProduct(product: event.product);

    add(LoadCartEvent(cartItems: cartItems));
  }

  Stream<CartState> _mapRemoveEventToState(RemovePFromCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Remove the product from cart here
    cartItems.removeProduct(product: event.product);

    add(LoadCartEvent(cartItems: cartItems));
  }
}
