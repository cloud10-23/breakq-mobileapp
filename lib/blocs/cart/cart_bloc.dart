import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final BudgetBloc budgetBloc;
  CartBloc({this.budgetBloc}) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitCartEvent) {
      yield* _mapInitCartEventToState(event);
    } else if (event is LoadCartEvent) {
      yield* _mapLoadCartEventToState(event);
    } else if (event is AddPToCartEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is BulkAddPToCartEvent) {
      yield* _mapBulkAddEventToState(event);
    } else if (event is ReduceQOfPCartEvent) {
      yield* _mapReduceQEventToState(event);
    } else if (event is RemovePFromCartEvent) {
      yield* _mapRemoveEventToState(event);
    } else if (event is ResetCartEvent) {
      yield* _mapResetCartEventToState(event);
    }
  }

  Stream<CartState> _mapInitCartEventToState(InitCartEvent event) async* {
    yield CartLoaded(cart: Cart(cartItems: Map<Product, int>()));
  }

  Stream<CartState> _mapLoadCartEventToState(LoadCartEvent event) async* {
    //Total items:
    int _noOfProducts = 0;
    double _cartValue = 0.0;
    double _orgCartValue = 0.0;
    event.cartItems.cartItems.keys.forEach((item) {
      _noOfProducts += event.cartItems.cartItems[item];
      _cartValue += event.cartItems.cartItems[item] * item.price;
      _orgCartValue += event.cartItems.cartItems[item] * item.oldPrice;
    });

    event.cartItems.setNoOfProducts = _noOfProducts;
    event.cartItems.setCartValue(_orgCartValue, _cartValue);

    if (event.isAdded) {
      /// Notifying the BudgetBLoc of addition
      budgetBloc.add(BudgetProductAddedEvent(
          cartValue: event.cartItems.cartValue.totalAmnt));
    }

    yield CartLoaded(cart: event.cartItems);
  }

  Stream<CartState> _mapAddEventToState(AddPToCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Add the product to cart here
    cartItems.addProduct(product: event.product, quantity: event.qty);

    add(LoadCartEvent(cartItems: cartItems, isAdded: true));
  }

  Stream<CartState> _mapBulkAddEventToState(BulkAddPToCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Add all the products to cart here
    cartItems.bulkAddProducts(newCartItems: event.cartItems);

    add(LoadCartEvent(cartItems: cartItems, isAdded: true));
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

  Stream<CartState> _mapResetCartEventToState(ResetCartEvent event) async* {
    yield CartLoading();

    add(LoadCartEvent(cartItems: Cart(cartItems: Map<Product, int>())));
  }
}
