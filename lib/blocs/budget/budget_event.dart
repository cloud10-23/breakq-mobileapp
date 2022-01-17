part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class BudgetProductAddedEvent extends BudgetEvent {
  BudgetProductAddedEvent({this.cartValue});
  final double cartValue;
}

class BudgetSetEvent extends BudgetEvent {
  BudgetSetEvent({this.budget});
  final double budget;
}

class BudgetCheckEvent extends BudgetEvent {
  BudgetCheckEvent({this.cartValue});
  final double cartValue;
}

class BudgetResetEvent extends BudgetEvent {}

class BudgetIgnoreEvent extends BudgetEvent {}
