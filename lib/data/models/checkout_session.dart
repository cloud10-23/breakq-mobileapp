import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_model.dart';
import 'package:breakq/data/models/timetable_model.dart';

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
    this.apiError = '',
    this.address,
    this.selectedAddress,
    this.timetables,
    this.selectedDateRange = 0,
    this.selectedTimestamp = 0,
  });

  CheckoutSession rebuild({
    ChCurrentStep currentStep,
    Cart cartProducts,
    String billNo,
    String orderNo,
    String transactionNo,
    bool isCompleted,
    bool isLoading,
    String apiError,
    List<Address> address,
    int selectedAddress,
    List<TimeSlot> timetables,
    int selectedDateRange,
    int selectedTimestamp,
  }) {
    return CheckoutSession(
      currentStep: currentStep ?? this.currentStep,
      cartProducts: cartProducts ?? this.cartProducts,
      billNo: billNo ?? this.billNo,
      orderNo: orderNo ?? this.orderNo,
      transactionNo: transactionNo ?? this.transactionNo,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      apiError: apiError ?? '',
      address: address ?? this.address,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      timetables: timetables ?? this.timetables,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      selectedTimestamp: selectedTimestamp ?? this.selectedTimestamp,
    );
  }

  final ChCurrentStep currentStep;
  final Cart cartProducts;
  final bool isCompleted, isLoading;
  final String orderNo, billNo, transactionNo;
  final String apiError;
  final List<Address> address;
  final int selectedAddress;
  final List<TimeSlot> timetables;
  final int selectedDateRange;
  final int selectedTimestamp;

  @override
  String toString() {
    return 'Checkout Model';
  }
}
