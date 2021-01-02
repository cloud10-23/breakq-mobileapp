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
    } else if (event is AddPToCartEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is RemovePFromCartEvent) {
      yield* _mapRemoveEventToState(event);
    }
  }

  Stream<CartState> _mapInitCartEventToState(InitCartEvent event) async* {
    yield CartLoaded(cartItems: CartModel(cartItems: List<CartItem>()));
  }

  Stream<CartState> _mapAddEventToState(AddPToCartEvent event) async* {
    CartModel cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cartItems;
    yield CartLoading();

    // Add the product to cart here
    cartItems.addProduct(product: event.product);

    //Total items:
    int _total = 0;
    cartItems.cartItems.forEach((item) {
      _total += item.quantity;
    });

    yield CartLoaded(cartItems: cartItems, totalItems: _total);
  }

  Stream<CartState> _mapRemoveEventToState(RemovePFromCartEvent event) async* {
    CartModel cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cartItems;
    yield CartLoading();

    // Remove the product from cart here
    cartItems.removeProduct(product: event.product);

    //Total items:
    int _total = 0;
    cartItems.cartItems.forEach((item) {
      _total += item.quantity;
    });

    yield CartLoaded(cartItems: cartItems, totalItems: _total);
  }
}
