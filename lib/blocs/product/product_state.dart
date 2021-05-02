part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  @override
  String toString() => '$runtimeType';
}

class InitialProductState extends ProductState {}

class RefreshSuccessProductState extends ProductState {
  RefreshSuccessProductState(this.session);

  final ProductSessionModel session;
}

class RefreshFailureProductState extends ProductState {}
