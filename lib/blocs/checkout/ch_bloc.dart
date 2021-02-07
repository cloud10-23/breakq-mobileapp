import 'dart:async';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:flutter/material.dart';
import 'package:breakq/blocs/base_bloc.dart';

part 'ch_event.dart';
part 'ch_state.dart';

class CheckoutBloc extends BaseBloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({@required this.cartBloc}) : super(InitialChState());

  final CartBloc cartBloc;

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is LoadCartChEvent) {
      yield* _mapLoadCartChEventToState(event);
    } else if (event is CheckoutTypeSelectedChEvent) {
      yield* _mapCheckoutSelectedChEventToState(event);
    } else if (event is NextPressedChEvent) {
      yield* _mapNextPressedChEventToState(event);
    } else if (event is BackPressedChEvent) {
      yield* _mapBackPressedChEvent(event);
    } else if (event is PaymentDoneChEvent) {
      yield* _mapPaymentDoneChEvent(event);
    } else if (event is LoadAddressChEvent) {
      yield* _mapLoadAddressChEventToState(event);
    } else if (event is AddressAddedChEvent) {
      yield* _mapAddressAddedChEventToState();
    } else if (event is AddressSelectedChEvent) {
      yield* _mapAddressSelectedChEventToState(event);
    } else if (event is GenerateBillChEvent) {
      yield* _mapGenerateBillChEventToState();
    } else if (event is ClearCartChEvent) {
      yield* _mapClearCartChEventToState(event);
    }
  }

  Stream<CheckoutState> _mapLoadCartChEventToState(
      LoadCartChEvent event) async* {
    try {
      Cart cartItems = (cartBloc.state as CartLoaded).cart;
      if (cartItems?.cartItems?.isNotEmpty ?? false)
        yield SessionRefreshSuccessChState(
            CheckoutSession(cartProducts: cartItems));
      else
        yield LoadFailureChState();
    } catch (e) {
      yield LoadFailureChState();
    }
  }

  Stream<CheckoutState> _mapCheckoutSelectedChEventToState(
      CheckoutTypeSelectedChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      final CheckoutSession newSession = session.rebuild(
        currentStep: ChCurrentStep(checkoutType: event.type, step: 0),
      );

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapNextPressedChEventToState(
      NextPressedChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      /// Do the API call for generating the bill

      CheckoutSession newSession = session;

      switch (session.currentStep.checkoutType) {
        case CheckoutType.walkIn:
          if (session.currentStep.step == 0) {
            newSession = session.rebuild(
              currentStep: session.currentStep.rebuild(step: 1),
              title: 'Bill Generated!',
              billNo: "1234556678",
            );
            // _subtitle ;
          } else if (session.currentStep.step == 1) {
            add(PaymentDoneChEvent());
            // if (session.selectedProductIds == null ||
            //     session.selectedProductIds.isEmpty) {
            //   UI.showErrorDialog(context,
            //       message: L10n.of(context).QSWarningProducts,
            //       onPressed: () => Navigator.pop(context));
            // }
          }
          break;
        case CheckoutType.pickUp:
          if (session.currentStep.step == 0) {
            newSession = session.rebuild(
              billNo: "1234556678",
              isCompleted: true,
            );
            add(ClearCartChEvent());
          }
          break;
        case CheckoutType.delivery:
          if (session.currentStep.step == 0) {
            List<DeliveryAddress> address = [
              DeliveryAddress(
                name: "Jon Doe",
                addLine1: "No. 5, 5th Lane",
                addLine2: "Church Street",
                cityDistTown: "Riverdale",
                state: "California",
                pinCode: "610032",
                landmark: "DineOut Restraunt",
                phone: "1234567890",
              ),
              DeliveryAddress(
                name: "Katherine Doe",
                addLine1: "No. 5, 5th Lane ",
                addLine2: "Church Street",
                cityDistTown: "Riverdale",
                state: "California",
                pinCode: "610032",
                landmark: "DineOut Restraunt",
                phone: "0987654321",
              ),
            ];
            newSession = session.rebuild(
              currentStep: session.currentStep.rebuild(step: 1),
              title: 'Select Address',
              billNo: "12345678910",
              address: address,
            );
          } else if (session.currentStep.step == 1) {
            newSession = session.rebuild(
              isCompleted: true,
            );
            add(ClearCartChEvent());
          }
          break;
      }

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapBackPressedChEvent(
      BackPressedChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      final CheckoutSession newSession = session.rebuild(
          currentStep: session.currentStep.decStep(), title: "");

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapPaymentDoneChEvent(
      PaymentDoneChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      /// Do the API call for checking the payment is done

      final CheckoutSession newSession = session.rebuild(
        isCompleted: true,
      );
      add(ClearCartChEvent());

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapLoadAddressChEventToState(
      LoadAddressChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {}
  }

  Stream<CheckoutState> _mapAddressAddedChEventToState() async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      /// Load all the bills:
      // final List<Bill> _bills = session.bills
      //     .where((bill) => session.selectedBillIds.contains(bill.billNo))
      //     .toList();
      // List<Product> _products = List();
      // for (final Bill bill in _bills) {
      //   _products.addAll(bill.products.cartItems.keys);
      // }

      // // Any other way to eliminate duplicate products if this does not work
      // _products = _products.toSet().toList();

      // if (_products?.isEmpty ?? true) {
      //   yield LoadFailureChState();
      // } else {
      //   final QSSessionModel newSession =
      //       session.rebuild(products: _products, selectedProductIds: {});
      //   yield SessionRefreshSuccessChState(newSession);
      // }
    }
  }

  Stream<CheckoutState> _mapAddressSelectedChEventToState(
      AddressSelectedChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      final CheckoutSession newSession =
          session.rebuild(selectedAddress: event.index);
      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapClearCartChEventToState(
      ClearCartChEvent event) async* {
    cartBloc.add(ResetCartEvent());
  }

  Stream<CheckoutState> _mapGenerateBillChEventToState() async* {
    // if (state is SessionRefreshSuccessChState) {
    //   final CheckoutSession session =
    //       (state as SessionRefreshSuccessChState).session;

    //   if (session.selectedProductIds?.isNotEmpty ?? false) {
    //     Map<Product, int> cartItems = {};
    //     session.selectedProductIds.forEach((productId, qty) {
    //       cartItems[session.products
    //           .firstWhere((product) => product.id == productId)] = qty;
    //     });
    //     cartBloc.add(BulkAddPToCartEvent(cartItems: cartItems));

    //     yield SessionRefreshSuccessChState(session.rebuild(
    //       isSubmitted: true,
    //     ));
    //   }
    // }
  }
}