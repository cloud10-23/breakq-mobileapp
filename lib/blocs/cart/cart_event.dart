part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class InitCartEvent extends CartEvent {}

class AddPToCartEvent extends CartEvent {
  AddPToCartEvent({this.product});
  final ProductModel product;
}

class RemovePFromCartEvent extends CartEvent {
  RemovePFromCartEvent({this.product});
  final ProductModel product;
}

class ResetCartEvent extends CartEvent {}
