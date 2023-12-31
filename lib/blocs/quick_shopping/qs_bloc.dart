import 'dart:async';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/data/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:breakq/blocs/base_bloc.dart';
import 'package:breakq/data/models/qs_session_model.dart';
import 'package:breakq/data/models/product_model.dart';

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
    } else if (event is SelectAllBillsQSEvent) {
      yield* _mapSelectAllBillsQSEventToState(event);
    } else if (event is DeSelectAllBillsQSEvent) {
      yield* _mapDeSelectAllBillsQSEventToState(event);
    } else if (event is ProductAddedQSEvent) {
      yield* _mapSelectProductQSEventToState(event);
    } else if (event is ProductMinusQSEvent) {
      yield* _mapUnselectProductQSEventToState(event);
    } else if (event is DeleteProductQSEvent) {
      yield* _mapDeleteProductQSEventToState(event);
    } else if (event is SelectAllProductsQSEvent) {
      yield* _mapSelectAllProductQSEventToState(event);
    } else if (event is DeleteAllProductsQSEvent) {
      yield* _mapDeleteAllProductQSEventToState(event);
    } else if (event is LoadProductsQSEvent) {
      yield* _mapLoadProductsQSEventToState();
    } else if (event is AddToCartQSEvent) {
      yield* _mapAddToCartQSEventToState();
    }
  }

  Stream<QSState> _mapLoadBillsEventToState(LoadBillsQSEvent event) async* {
    final _orders = event.orders;

    if (_orders == null || _orders.length <= 0) {
      yield LoadFailureQSState();
    } else {
      yield SessionRefreshSuccessQSState(QSSessionModel(
        orders: _orders,
        selectedBillIds: <String>[],
      ));
    }
  }

  Stream<QSState> _mapSelectBillQSEventToState(
      BillSelectedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedBillIds.add(event.order.billNo.toString());

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
      session.selectedBillIds.remove(event.order.billNo.toString());

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: session.selectedBillIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapSelectAllBillsQSEventToState(
      SelectAllBillsQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedBillIds.clear();
      session.orders.forEach((bill) {
        session.selectedBillIds.add(bill.billNo.toString());
      });

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: session.selectedBillIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapDeSelectAllBillsQSEventToState(
      DeSelectAllBillsQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      final QSSessionModel newSession = session.rebuild(
        selectedBillIds: [],
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapLoadProductsQSEventToState() async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      /// Load all the bills:
      final List<Order> _orders = session.orders
          .where((order) =>
              session.selectedBillIds.contains(order.billNo.toString()))
          .toList();
      Set<Product> _products = {};
      for (final Order order in _orders) {
        _products.addAll(order.products.map((p) => p.product));
      }

      if (_products?.isEmpty ?? true) {
        yield LoadFailureQSState();
      } else {
        final QSSessionModel newSession = session
            .rebuild(products: _products.toList(), selectedProductIds: {});
        yield SessionRefreshSuccessQSState(newSession);
      }
    }
  }

  Stream<QSState> _mapSelectProductQSEventToState(
      ProductAddedQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      if (session.selectedProductIds.containsKey(event.product.id))
        session.selectedProductIds[event.product.id] += event.quantity;
      else
        session.selectedProductIds.addAll({event.product.id: event.quantity});

      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: session.selectedProductIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapUnselectProductQSEventToState(
      ProductMinusQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      final int oldQty = session.selectedProductIds[event.product.id];

      if (oldQty <= 1 || oldQty < event.quantity)
        session.selectedProductIds.remove(event.product.id);
      else
        session.selectedProductIds[event.product.id] -= event.quantity;

      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: session.selectedProductIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapDeleteProductQSEventToState(
      DeleteProductQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.selectedProductIds.remove(event.product.id);

      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: session.selectedProductIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapSelectAllProductQSEventToState(
      SelectAllProductsQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      session.products.forEach((product) {
        if (!session.selectedProductIds.containsKey(product.id))
          session.selectedProductIds.addAll({product.id: 1});
      });
      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: session.selectedProductIds,
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapDeleteAllProductQSEventToState(
      DeleteAllProductsQSEvent event) async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      final QSSessionModel newSession = session.rebuild(
        selectedProductIds: {},
      );

      yield SessionRefreshSuccessQSState(newSession);
    }
  }

  Stream<QSState> _mapAddToCartQSEventToState() async* {
    if (state is SessionRefreshSuccessQSState) {
      final QSSessionModel session =
          (state as SessionRefreshSuccessQSState).session;

      if (session.selectedProductIds?.isNotEmpty ?? false) {
        Map<Product, int> cartItems = {};
        session.selectedProductIds.forEach((productId, qty) {
          cartItems[session.products
              .firstWhere((product) => product.id == productId)] = qty;
        });
        cartBloc.add(BulkAddPToCartEvent(cartItems: cartItems));

        yield SessionRefreshSuccessQSState(session.rebuild(
          isSubmitted: true,
        ));
      }
    }
  }
}
