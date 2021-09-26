import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/data/models/timeslot_model.dart';

class ChCurrentStep {
  final CheckoutType checkoutType;
  final int step;
  const ChCurrentStep({this.checkoutType, this.step = 0});

  ChCurrentStep rebuild({
    CheckoutType checkoutType,
    int step,
  }) {
    return ChCurrentStep(
      checkoutType: checkoutType ?? this.checkoutType,
      step: step ?? this.step,
    );
  }

  ChCurrentStep decStep() {
    return ChCurrentStep(
      checkoutType: this.checkoutType,
      step: this.step - 1,
    );
  }
}

class CheckoutSession {
  CheckoutSession({
    this.currentStep =
        const ChCurrentStep(checkoutType: CheckoutType.walkIn, step: 0),
    this.cartProducts,
    this.billNo,
    this.orderNo,
    this.transactionNo,
    this.isCompleted = false,
    this.isLoading = false,
    this.isPaying = false,
    this.apiError = '',
    this.address,
    this.selectedAddress = -1,
    this.timetables,
    this.selectedDateIndex = 0,
    this.selectedTimeIndex = -1,
    this.order,
  });

  CheckoutSession rebuild({
    ChCurrentStep currentStep,
    Cart cartProducts,
    String billNo,
    String orderNo,
    String transactionNo,
    bool isCompleted,
    bool isLoading,
    bool isPaying,
    String apiError,
    List<Address> address,
    int selectedAddress,
    List<TimeslotModel> timetables,
    int selectedDateRange,
    int selectedTimeIndex,
    Order order,
  }) {
    return CheckoutSession(
      currentStep: currentStep ?? this.currentStep,
      cartProducts: cartProducts ?? this.cartProducts,
      billNo: billNo ?? this.billNo,
      orderNo: orderNo ?? this.orderNo,
      transactionNo: transactionNo ?? this.transactionNo,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      isPaying: isPaying ?? this.isPaying,
      apiError: apiError ?? '',
      address: address ?? this.address,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      timetables: timetables ?? this.timetables,
      selectedDateIndex: selectedDateRange ?? this.selectedDateIndex,
      selectedTimeIndex: selectedTimeIndex ?? this.selectedTimeIndex,
      order: order ?? this.order,
    );
  }

  final ChCurrentStep currentStep;
  final Cart cartProducts;
  final bool isCompleted, isLoading, isPaying;
  final String orderNo, billNo, transactionNo;
  final String apiError;
  final List<Address> address;
  final int selectedAddress;
  final List<TimeslotModel> timetables;
  final int selectedDateIndex;
  final int selectedTimeIndex;
  final Order order;

  @override
  String toString() {
    return 'Checkout Model';
  }
}
