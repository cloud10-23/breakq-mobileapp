part of 'qs_bloc.dart';

abstract class QSEvent {
  @override
  String toString() => '$runtimeType';
}

class LoadBillsQSEvent extends QSEvent {}

class SelectAllBillsQSEvent extends QSEvent {}

class DeSelectAllBillsQSEvent extends QSEvent {}

class BillSelectedQSEvent extends QSEvent {
  BillSelectedQSEvent({this.bill});

  final Bill bill;
}

class BillUnselectedQSEvent extends QSEvent {
  BillUnselectedQSEvent({this.bill});

  final Bill bill;
}

class ProductSelectedQSEvent extends QSEvent {
  ProductSelectedQSEvent({this.product});

  final Product product;
}

class ProductUnselectedQSEvent extends QSEvent {
  ProductUnselectedQSEvent({this.product});

  final Product product;
}

class SelectAllProductsQSEvent extends QSEvent {}

class DeSelectAllProductsQSEvent extends QSEvent {}

class LoadProductsQSEvent extends QSEvent {}

class AddToCartQSEvent extends QSEvent {}
