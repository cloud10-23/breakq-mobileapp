part of 'orders_bloc.dart';

abstract class OrdersState {
  @override
  String toString() => '$runtimeType';
}

class OrdersInitialState extends OrdersState {}

// class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  OrdersLoadedState({@required this.orders});

  final List<Order> orders;
}

class OrdersLoadFailureState extends OrdersState {}
