import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/repositories/cart_repository.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_preferences.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final BudgetBloc budgetBloc;
  final HomeBloc homeBloc;
  final CartRepository _cartRepo = CartRepository();
  final List<Product> recentlyScanned = [], suggestedProducts = [];
  CartBloc({this.budgetBloc, this.homeBloc}) : super(CartInitial());

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
    } else if (event is RecentlyScannedEvent) {
      yield* _mapRecentlyScannedCartEventToState(event);
    }
  }

  Stream<CartState> _mapInitCartEventToState(InitCartEvent event) async* {
    final _productsRepo = ProductsRepository();
    suggestedProducts
      ..clear()
      ..addAll(await _productsRepo.getExclusiveProduct());
    final List<String> recSIds = await getIt
        .get<AppPreferences>()
        .getStringList(PreferenceKey.recentlyScanned);

    if (recSIds != null) {
      for (final id in recSIds) {
        recentlyScanned
            .addAll(await _productsRepo.getProducts(productCode: id));
      }
    }

    homeBloc
        .add(UpdateRecentlyScannedHomeEvent(recentlyScanned: recentlyScanned));
    yield CartLoaded(
        suggestedProducts: suggestedProducts,
        recentlyScanned: recentlyScanned,
        cart: Cart.fromCartApi(await _cartRepo.getCart()));
  }

  Stream<CartState> _mapLoadCartEventToState(LoadCartEvent event) async* {
    /// Update the UI first
    yield CartLoaded(
        suggestedProducts: suggestedProducts,
        recentlyScanned: recentlyScanned,
        cart: event.cartItems);

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
      budgetBloc.add(
          BudgetProductAddedEvent(cartValue: newCart.cartValue.finalAmount));
    }
    yield CartLoaded(
        suggestedProducts: suggestedProducts,
        recentlyScanned: recentlyScanned,
        cart: newCart);
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
    yield CartLoading();

    if (await _cartRepo.deleteCart()) {
      print("Cleared cart!");
    } else {
      /// ERROR
      print("Error clearing cart!");
    }
    add(LoadCartEvent(
      cartItems: Cart(cartItems: {}, cartValue: Price(), noOfProducts: 0),
      newCartItems: {},
    ));
  }

  Stream<CartState> _mapRecentlyScannedCartEventToState(
      RecentlyScannedEvent event) async* {
    Cart cart;
    if (state is CartLoaded) cart = (state as CartLoaded).cart;
    recentlyScanned.remove(event.product);
    recentlyScanned.add(event.product);
    final List<String> recentlyScannedIds =
        await getIt.get<AppPreferences>().getStringList('recentlyScanned');

    if (recentlyScannedIds == null) {
      await getIt.get<AppPreferences>().setStringList(
          PreferenceKey.recentlyScanned, [event.product.id.toString()]);
    } else {
      // This sets the maximum recently scanned items
      if (recentlyScannedIds.length >= 20) recentlyScannedIds.removeAt(0);
      recentlyScannedIds.remove(event.product.id.toString());
      recentlyScannedIds.add(event.product.id.toString());
      await getIt
          .get<AppPreferences>()
          .setStringList(PreferenceKey.recentlyScanned, recentlyScannedIds);
    }

    homeBloc
        .add(UpdateRecentlyScannedHomeEvent(recentlyScanned: recentlyScanned));

    // Also store the product ids
    yield CartLoaded(
      suggestedProducts: suggestedProducts,
      recentlyScanned: recentlyScanned,
      cart: cart,
    );
  }
}
