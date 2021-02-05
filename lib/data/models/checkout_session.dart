import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_model.dart';

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
    this.title,
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
    String title,
    List<DeliveryAddress> address,
    int selectedAddress,
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
      title: title ?? this.title,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  final ChCurrentStep currentStep;
  final Cart cartProducts;
  final bool isCompleted, isLoading;
  final String orderNo, billNo, transactionNo;
  final String apiError;
  final String title;
  final List<DeliveryAddress> address;
  final int selectedAddress;

  @override
  String toString() {
    return 'Checkout Model';
  }
}
