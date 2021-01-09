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
  AddPToCartEvent({this.product});
  final Product product;
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
