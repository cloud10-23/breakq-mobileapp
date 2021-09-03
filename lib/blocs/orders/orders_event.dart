part of 'orders_bloc.dart';

abstract class OrdersEvent {
  @override
  String toString() => '$runtimeType';
}

class LoadOrdersEvent extends OrdersEvent {}

class OrderSelectedQSEvent extends OrdersEvent {
  OrderSelectedQSEvent({this.order});

  final Order order;
}
