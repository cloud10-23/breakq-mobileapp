part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded({this.cart, this.hide = false});
  final Cart cart;
  final bool hide;

  @override
  List<Object> get props => [hide];
}
