import 'dart:async';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/data/models/payment.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/timeslot_model.dart';
import 'package:breakq/data/repositories/address_repository.dart';
import 'package:breakq/data/repositories/checkout_repository.dart';
import 'package:breakq/data/repositories/order_repository.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/blocs/base_bloc.dart';

part 'ch_event.dart';
part 'ch_state.dart';

class CheckoutBloc extends BaseBloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({@required this.cartBloc}) : super(InitialChState());

  final CartBloc cartBloc;
  final CheckoutRepository _checkoutRepository = CheckoutRepository();

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is LoadCartAndTypeChEvent) {
      yield* _mapLoadCartChEventToState(event);
    } else if (event is CheckoutTypeSelectedChEvent) {
      yield* _mapCheckoutSelectedChEventToState(event);
    } else if (event is NextPressedChEvent) {
      yield* _mapNextPressedChEventToState(event);
    } else if (event is BackPressedChEvent) {
      yield* _mapBackPressedChEvent(event);
    } else if (event is PaymentDoneChEvent) {
      yield* _mapPaymentDoneChEvent(event);
    } else if (event is LoadTimeSlots) {
      yield* _mapGetTimetablesCheckoutEventToState(event);
    } else if (event is DateRangeSetChEvent) {
      yield* _mapSetDateRangeCheckoutEventToState(event);
    } else if (event is TimestampSelectedChEvent) {
      yield* _mapSelectTimestampCheckoutEventToState(event);
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
    } else if (event is ClearAPIErrorChEvent) {
      yield* _mapClearAPIErrorEventToState(event);
    }
  }

  Future<String> initWalkin() async {
    return await _checkoutRepository.checkoutWalkin();
  }

  void initPickup() {
    add(LoadTimeSlots(type: CheckoutType.pickUp));
  }

  void initDelivery() {
    add(LoadAddressChEvent());
  }

  Stream<CheckoutState> _mapLoadCartChEventToState(
      LoadCartAndTypeChEvent event) async* {
    try {
      Cart cartItems = (cartBloc.state as CartLoaded).cart;
      if (cartItems?.cartItems?.isNotEmpty ?? false) {
        String billNo = "";
        bool isLoading = true;
        switch (event.type) {
          case CheckoutType.walkIn:
            billNo = await initWalkin();
            isLoading = false;
            break;
          case CheckoutType.pickUp:
            initPickup();
            break;
          case CheckoutType.delivery:
            initDelivery();
            break;
        }

        yield SessionRefreshSuccessChState(CheckoutSession(
            cartProducts: cartItems,
            billNo: billNo,
            isLoading: isLoading,
            currentStep: ChCurrentStep(checkoutType: event.type)));
      } else
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

      String _routeName = CheckoutNavigatorRoutes.walkin_1;
      String billNo = "";
      bool isLoading = true;
      switch (event.type) {
        case CheckoutType.walkIn:
          billNo = await initWalkin();
          isLoading = false;
          _routeName = CheckoutNavigatorRoutes.walkin_1;
          break;
        case CheckoutType.pickUp:
          initPickup();
          _routeName = CheckoutNavigatorRoutes.pickup_1;
          break;
        case CheckoutType.delivery:
          initDelivery();
          _routeName = CheckoutNavigatorRoutes.delivery_1;
          break;
      }

      getIt
          .get<AppGlobals>()
          .globalKeyCheckoutNavigator
          .currentState
          .pushReplacementNamed(_routeName);

      final CheckoutSession newSession = CheckoutSession(
        cartProducts: session.cartProducts,
        billNo: billNo,
        isLoading: isLoading,
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

      yield SessionRefreshSuccessChState(session.rebuild(isLoading: true));

      CheckoutSession newSession = session.rebuild(isLoading: false);

      switch (session.currentStep.checkoutType) {
        case CheckoutType.walkIn:

          /// If the type is Walkin then this will be triggered through API when
          /// the counter scans the code
          yield SessionRefreshSuccessChState(session.rebuild(isPaying: true));

          newSession = session.rebuild(isPaying: false);
          switch (session.currentStep.step) {
            case 0:
              // PAY was clicked
              newSession = session.rebuild(isLoading: false);
              if (await CheckoutRepository().checkoutPay(
                  billNo: session.billNo,
                  amount: Amount(
                    upi: UPI(
                        no: '53464532',
                        amount: session.cartProducts.cartValue.finalAmount),
                  )))
                add(PaymentDoneChEvent());
              else
                newSession =
                    session.rebuild(apiError: "Unable to process payment!");
              break;
          }

          break;
        case CheckoutType.pickUp:
          switch (session.currentStep.step) {
            case 0:
              if (session.selectedDateIndex < 0 ||
                  session.selectedTimeIndex < 0) {
                /// Then the user did not select a time slot
                /// Show an Error dialog
                yield LoadFailureChState();
              }
              newSession = session.rebuild(
                currentStep: session.currentStep.rebuild(step: 1),
              );
              getIt
                  .get<AppGlobals>()
                  .globalKeyCheckoutNavigator
                  .currentState
                  .pushNamed(CheckoutNavigatorRoutes.pickup_2);
              break;
            case 1:

              /// This is after the user confirms the self pick up
              /// Make an API request and conform the order
              ///
              /// API CALL to checkout with Time slot and get the bill no,
              yield SessionRefreshSuccessChState(
                  session.rebuild(isPaying: true));

              newSession = session.rebuild(isPaying: false);

              final selectedDateRange = session.selectedDateIndex;
              final selectedTimeSlot = session.selectedTimeIndex;
              final selectedDate = session.timetables[selectedDateRange];
              final timeslots = selectedDate.timeSchedules[selectedTimeSlot];
              final String billNo = await _checkoutRepository.checkoutWithTime(
                selectedDate.scheduleDate,
                timeslots.startTime,
                timeslots.endTime,
                CheckoutType.pickUp,
              );

              /// Do the API call for checking the payment is done
              // PAYMENT
              if (await CheckoutRepository().checkoutPay(
                  billNo: billNo,
                  amount: Amount(
                    upi: UPI(
                        no: '53464532',
                        amount: session.cartProducts.cartValue.finalAmount),
                  ))) {
                add(PaymentDoneChEvent());
                newSession = session.rebuild(
                  isLoading: false,
                  billNo: billNo,
                );
              } else
                newSession =
                    session.rebuild(apiError: "Unable to process payment!");
              break;
          }
          break;
        case CheckoutType.delivery:
          switch (session.currentStep.step) {
            case 0:
              if (session.selectedAddress >= 0) {
                add(LoadTimeSlots(type: CheckoutType.delivery));
                Cart cartProducts = Cart(
                  cartValue:
                      Price.addDelivery(session.cartProducts.cartValue, 10.0),
                  cartItems: session.cartProducts.cartItems,
                  noOfProducts: session.cartProducts.noOfProducts,
                );
                newSession = session.rebuild(
                  cartProducts: cartProducts,
                  currentStep: session.currentStep.rebuild(step: 1),
                );
                getIt
                    .get<AppGlobals>()
                    .globalKeyCheckoutNavigator
                    .currentState
                    .pushNamed(CheckoutNavigatorRoutes.delivery_2);
              } else {
                newSession = session.rebuild(
                    apiError: "Please add and select an address");
              }
              break;
            case 1:
              newSession = session.rebuild(
                currentStep: session.currentStep.rebuild(step: 2),
              );
              getIt
                  .get<AppGlobals>()
                  .globalKeyCheckoutNavigator
                  .currentState
                  .pushNamed(CheckoutNavigatorRoutes.delivery_3);
              // getIt
              //     .get<AppGlobals>()
              //     .globalKeyCheckoutNavigator
              //     .currentState
              //     .pushNamed(CheckoutNavigatorRoutes.deliver_1);
              break;
            case 2:

              /// API CALL to checkout with Time slot and get the bill no,
              ///
              yield SessionRefreshSuccessChState(
                  session.rebuild(isPaying: true));

              newSession = session.rebuild(isPaying: false);
              final selectedDateRange = session.selectedDateIndex;
              final selectedTimeSlot = session.selectedTimeIndex;
              final selectedDate = session.timetables[selectedDateRange];
              final timeslots = selectedDate.timeSchedules[selectedTimeSlot];

              final String billNo = await _checkoutRepository.checkoutWithTime(
                selectedDate.scheduleDate,
                timeslots.startTime,
                timeslots.endTime,
                CheckoutType.delivery,
                addressID: session.address[session.selectedAddress].addressId,
              );

              /// Do the API call for checking the payment is done
              // PAYMENT
              if (await CheckoutRepository().checkoutPay(
                  billNo: billNo,
                  amount: Amount(
                    upi: UPI(
                        no: '53464532',
                        amount: session.cartProducts.cartValue.finalAmount),
                  ))) {
                add(PaymentDoneChEvent());
                newSession = session.rebuild(
                  billNo: billNo,
                );
              } else
                newSession =
                    session.rebuild(apiError: "Unable to process payment!");
              break;
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
        currentStep: session.currentStep.decStep(),
      );
      getIt.get<AppGlobals>().globalKeyCheckoutNavigator.currentState.pop();

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapPaymentDoneChEvent(
      PaymentDoneChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      /// Do the API call for checking the payment is done
      final Order order = await MyOrderRepository().getOrder(session.billNo);

      final CheckoutSession newSession = session.rebuild(
        isCompleted: true,
        order: order,
      );
      add(ClearCartChEvent());

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapGetTimetablesCheckoutEventToState(
      LoadTimeSlots event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;
      yield SessionRefreshSuccessChState(session.rebuild(isLoading: true));

      final List<TimeslotModel> _timetables =
          await _checkoutRepository.getTimeSlots(event.type);
      final CheckoutSession newSession =
          session.rebuild(timetables: _timetables, isLoading: false);

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapSetDateRangeCheckoutEventToState(
      DateRangeSetChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;
      if (session.selectedDateIndex != event.dateRange) {
        final CheckoutSession newSession = session.rebuild(
          selectedDateRange: event.dateRange,
          selectedTimeIndex: -1,
        );

        yield SessionRefreshSuccessChState(newSession);
      }
    }
  }

  Stream<CheckoutState> _mapSelectTimestampCheckoutEventToState(
      TimestampSelectedChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;
      if (session.selectedTimeIndex != event.timeIndex) {
        final CheckoutSession newSession =
            session.rebuild(selectedTimeIndex: event.timeIndex);

        yield SessionRefreshSuccessChState(newSession);
      }
    }
  }

  Stream<CheckoutState> _mapLoadAddressChEventToState(
      LoadAddressChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;
      CheckoutSession newSession = session;

      /// Do the API call for loading addresses
      List<Address> address = await AddressRepository().getAddress();

      newSession = session.rebuild(
        address: address,
        selectedAddress: (address?.isNotEmpty ?? false) ? 0 : -1,
        isLoading: false,
      );

      yield SessionRefreshSuccessChState(newSession);
    }
  }

  Stream<CheckoutState> _mapAddressAddedChEventToState() async* {
    /// Load addresses:
    add(LoadAddressChEvent());
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

  Stream<CheckoutState> _mapClearAPIErrorEventToState(
      ClearAPIErrorChEvent event) async* {
    if (state is SessionRefreshSuccessChState) {
      final CheckoutSession session =
          (state as SessionRefreshSuccessChState).session;

      final CheckoutSession newSession = session.rebuild(apiError: '');
      yield SessionRefreshSuccessChState(newSession);
    }
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
