import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final BudgetBloc budgetBloc;
  final AuthBloc authBloc;
  final CartRepository _cartRepo = CartRepository();
  CartBloc({this.budgetBloc, this.authBloc}) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is InitCartEvent) {
      yield* _mapInitCartEventToState(event);
    } else if (event is InitCartFromAPIEvent) {
      yield* _mapInitCartFromAPIEventToState(event);
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

  Stream<CartState> _mapInitCartFromAPIEventToState(
      InitCartFromAPIEvent event) async* {
    yield CartLoaded(cart: Cart.fromCartApi(await _cartRepo.getCart()));
  }

  Stream<CartState> _mapLoadCartEventToState(LoadCartEvent event) async* {
    /// Update the UI first
    yield CartLoaded(cart: event.cartItems);

    /// ======== UPDATE THE API HERE ======== ///
    for (final item in event.newCartItems.keys)
      await _cartRepo.addOrUpdateCart(AddCartModel(
        itemCode: item.id,
        qty: event.newCartItems[item],
      ));

    /// ======== Get the new CART from API ======= ///

    final newCartProducts = await _cartRepo.getCart();
    final newCart = Cart.fromCartApi(newCartProducts);

    if (event.isAdded) {
      /// Notifying the BudgetBLoc of addition
      budgetBloc
          .add(BudgetProductAddedEvent(cartValue: newCart.cartValue.totalAmnt));
    }
    yield CartLoaded(cart: newCart);
  }

  Stream<CartState> _mapAddEventToState(AddPToCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Add the product to cart here
    final qty =
        cartItems.addProduct(product: event.product, quantity: event.qty);

    add(LoadCartEvent(
        cartItems: cartItems,
        newCartItems: {event.product: qty},
        isAdded: true));
  }

  Stream<CartState> _mapBulkAddEventToState(BulkAddPToCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Add all the products to cart here
    cartItems.bulkAddProducts(newCartItems: event.cartItems);

    add(LoadCartEvent(
        cartItems: cartItems, newCartItems: event.cartItems, isAdded: true));
  }

  Stream<CartState> _mapReduceQEventToState(ReduceQOfPCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Remove the product from cart here
    final qty = cartItems.reduceQOfProduct(product: event.product);

    add(LoadCartEvent(
      cartItems: cartItems,
      newCartItems: {event.product: qty},
    ));
  }

  Stream<CartState> _mapRemoveEventToState(RemovePFromCartEvent event) async* {
    Cart cartItems;
    if (state is CartLoaded) cartItems = (state as CartLoaded).cart;
    yield CartLoading();

    // Remove the product from cart here
    cartItems.removeProduct(product: event.product);

    add(LoadCartEvent(
      cartItems: cartItems,
      newCartItems: {event.product: 0},
    ));
  }

  Stream<CartState> _mapResetCartEventToState(ResetCartEvent event) async* {
    Cart cart;
    if (state is CartLoaded) cart = (state as CartLoaded).cart;
    yield CartLoading();

    if (await _cartRepo.deleteCart())
      yield CartLoaded(cart: Cart(cartItems: Map<Product, int>()));
    else {
      /// ERROR
      print("Error clearing cart!");
      yield CartLoaded(cart: cart);
    }
  }
}
