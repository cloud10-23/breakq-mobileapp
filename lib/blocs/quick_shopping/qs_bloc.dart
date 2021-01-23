import 'dart:async';
import 'dart:math';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/data/repositories/bill_repository.dart';
import 'package:flutter/material.dart';
import 'package:breakq/blocs/base_bloc.dart';
import 'package:breakq/data/models/booking_session_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/bill_model.dart';

part 'qs_event.dart';
part 'qs_state.dart';

class QSBloc extends BaseBloc<QSEvent, QSState> {
  QSBloc({@required this.cartBloc}) : super(InitialQSState());

  final CartBloc cartBloc;

  @override
  Stream<QSState> mapEventToState(QSEvent event) async* {
    if (event is LoadBillsQSEvent) {
      yield* _mapLoadBillsEventToState(event);
    } else if (event is BillSelectedQSEvent) {
      yield* _mapSelectBillQSEventToState(event);
    } else if (event is BillUnselectedQSEvent) {
      yield* _mapUnselectBillQSEventToState(event);
    } else if (event is ProductSelectedQSEvent) {
      yield* _mapSelectProductQSEventToState(event);
    } else if (event is ProductUnselectedQSEvent) {
      yield* _mapUnselectProductQSEventToState(event);
    } else if (event is LoadProductsQSEvent) {
      yield* _mapLoadProductsQSEventToState();
    } else if (event is AddToCartQSEvent) {
      yield* _mapAddToCartQSEventToState();
    }
  }

  Stream<QSState> _mapLoadBillsEventToState(LoadBillsQSEvent event) async* {
    /// Load all the bills:
    final List<Bill> _bills = await BillsRepository().getBills();

    // BillsRepo.getBills();

    if (_bills == null) {
      yield LoadFailureQSState();
    } else {
      yield SessionRefreshSuccessQSState(QSSessionModel(
        bills: _bills,
        selectedBillIds: <String>[],
      ));
    }
  }

  Stream<QSState> _mapSelectBillQSEventToState(
      BillSelectedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedBillIds.add(event.bill.billNo);

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: session.selectedBillIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapUnselectBillQSEventToState(
      BillUnselectedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;
      session.selectedBillIds.remove(event.bill.billNo);

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: session.selectedBillIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapSelectProductQSEventToState(
      ProductSelectedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedProductIds.add(event.product.id);

      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: session.selectedProductIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapUnselectProductQSEventToState(
      ProductUnselectedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedProductIds.remove(event.product.id);

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: session.selectedBillIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapAddToCartQSEventToState() async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      if (session.selectedProductIds?.isEmpty ?? true) {
        yield SessionRefreshSuccessQSState(session);
      } else {
        cartBloc.add(BulkAddPToCartEvent(
            products: session.products
                .where((product) =>
                    session.selectedProductIds.contains(product.id))
                .toList()));

        yield SessionRefreshSuccessQSState(session.rebuild(
          isSubmitted: true,
        ));
      }
    }
  }

  Stream<QSState> _mapLoadProductsQSEventToState() async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      /// Load all the bills:
      final List<Bill> _bills = session.bills
          .where((bill) => session.selectedBillIds.contains(bill.billNo))
          .toList();
      List<Product> _products = List();
      for (final Bill bill in _bills) {
        _products.addAll(
            bill.products.cartItems.map((cartItem) => cartItem.product));
      }

      // Any other way to eliminate duplicate products if this does not work
      _products = _products.toSet().toList();

      if (_products?.isEmpty ?? true) {
        yield LoadFailureQSState();
      } else {
        final QSSessionModel newSession = session.rebuild(
          products: _products,
          selectedProductIds: <int>[],
        );
        yield SessionRefreshSuccessQSState(newSession);
      }
    }
  }
}
