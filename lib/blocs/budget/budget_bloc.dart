import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  // final CartBloc cartBloc;
  // StreamSubscription cartSubscription;
  double budget = double.infinity;
  double cartValue = 0.0;

  BudgetBloc() : super(BudgetInitial());

  // BudgetBloc({this.cartBloc}) : super(BudgetInitial()) {
  //   cartSubscription = cartBloc.listen((state) {
  //     if (state is CartLoaded) {
  //       cartValue =
  //           ((cartBloc.state as CartLoaded)?.cart?.cartValue?.totalAmnt ?? 0.0);
  //       add(BudgetCheckEvent());
  //     }
  //   });
  // }
  @override
  Future<void> close() async {
    // cartSubscription.cancel();
    super.close();
  }

  @override
  Stream<BudgetState> mapEventToState(BudgetEvent event) async* {
    if (event is BudgetSetEvent) {
      yield* _mapSetBudgetEventToState(event);
    } else if (event is BudgetProductAddedEvent) {
      yield* _mapProductAddedEventToState(event);
    } else if (event is BudgetCheckEvent) {
      yield* _mapCheckBudgetEventToState(event);
    } else if (event is BudgetResetEvent) {
      yield* _mapResetBudgetEventToState(event);
    }
  }

  Stream<BudgetState> _mapSetBudgetEventToState(BudgetSetEvent event) async* {
    budget = event.budget ?? double.infinity;
    add(BudgetCheckEvent());
  }

  Stream<BudgetState> _mapProductAddedEventToState(
      BudgetProductAddedEvent event) async* {
    cartValue = event.cartValue;
    add(BudgetCheckEvent());
  }

  Stream<BudgetState> _mapCheckBudgetEventToState(
      BudgetCheckEvent event) async* {
    /// Check for the value if it's exceeding and decide
    /// wheteher it exceeds the budget

    if (cartValue > budget) {
      yield BudgetExceeded(exceededAmnt: cartValue - budget);
    } else {
      yield BudgetInitial();
    }
  }

  Stream<BudgetState> _mapResetBudgetEventToState(
      BudgetResetEvent event) async* {
    budget = double.infinity;
    yield BudgetInitial();
  }
}
