part of 'qs_bloc.dart';

abstract class QSEvent {
  @override
  String toString() => '$runtimeType';
}

class LoadBillsQSEvent extends QSEvent {}

class SelectAllBillsQSEvent extends QSEvent {}

class DeSelectAllBillsQSEvent extends QSEvent {}

class BillSelectedQSEvent extends QSEvent {
  BillSelectedQSEvent({this.order});

  final Order order;
}

class BillUnselectedQSEvent extends QSEvent {
  BillUnselectedQSEvent({this.order});

  final Order order;
}

class LoadProductsQSEvent extends QSEvent {}

class ProductAddedQSEvent extends QSEvent {
  ProductAddedQSEvent({this.product, this.quantity = 1});

  final Product product;
  final int quantity;
}

class ProductMinusQSEvent extends QSEvent {
  ProductMinusQSEvent({this.product, this.quantity = 1});

  final Product product;
  final int quantity;
}

class DeleteProductQSEvent extends QSEvent {
  DeleteProductQSEvent({this.product});

  final Product product;
}

class SelectAllProductsQSEvent extends QSEvent {}

class DeleteAllProductsQSEvent extends QSEvent {}

class AddToCartQSEvent extends QSEvent {}
