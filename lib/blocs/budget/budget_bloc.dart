import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  // final CartBloc cartBloc;
  // StreamSubscription cartSubscription;
  double budget = double.infinity;
  double cartValue = 0.0;
  bool ignore = false;

  BudgetBloc() : super(BudgetInitial()) {
    on<BudgetSetEvent>((event, emit) async {
      budget = event.budget ?? double.infinity;
      ignore = false;
      add(BudgetCheckEvent());
    });

    on<BudgetProductAddedEvent>((event, emit) async {
      cartValue = event.cartValue;
      if (!ignore) add(BudgetCheckEvent());
    });
    on<BudgetCheckEvent>((event, emit) async {
      /// Check for the value if it's exceeding and decide
      /// wheteher it exceeds the budget

      if (cartValue > budget) {
        emit(BudgetExceeded(exceededAmnt: cartValue - budget));
      } else {
        emit(BudgetInitial());
      }
    });
    on<BudgetResetEvent>((event, emit) async {
      budget = double.infinity;
      emit(BudgetInitial());
    });
    on<BudgetIgnoreEvent>((event, emit) async {
      ignore = true;
    });
  }
}
