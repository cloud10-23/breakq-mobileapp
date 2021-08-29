part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded({this.cart, this.recentlyScanned});
  final Cart cart;
  final List<Product> recentlyScanned;

  factory CartLoaded.rebuild({
    CartLoaded cartLoaded,
    Cart cart,
    List<Product> recentlyScanned,
  }) {
    return CartLoaded(
      recentlyScanned: recentlyScanned ?? cartLoaded.recentlyScanned,
      cart: cart,
    );
  }

  @override
  List<Object> get props => [cart];
}
