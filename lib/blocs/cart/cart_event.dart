part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class InitCartEvent extends CartEvent {}

class LoadCartEvent extends CartEvent {
  LoadCartEvent({this.cartItems});
  final Cart cartItems;
}

class AddPToCartEvent extends CartEvent {
  AddPToCartEvent({this.product, this.qty = 1});
  final Product product;
  final int qty;
}

class BulkAddPToCartEvent extends CartEvent {
  BulkAddPToCartEvent({this.products});
  final List<Product> products;
}

class ReduceQOfPCartEvent extends CartEvent {
  ReduceQOfPCartEvent({this.product});
  final Product product;
}

class RemovePFromCartEvent extends CartEvent {
  RemovePFromCartEvent({this.product});
  final Product product;
}

class ResetCartEvent extends CartEvent {}

class SetFABEvent extends CartEvent {
  SetFABEvent({this.hide});
  final bool hide;
}
