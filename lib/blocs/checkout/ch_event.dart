part of 'ch_bloc.dart';

abstract class CheckoutEvent {
  @override
  String toString() => '$runtimeType';
}

class LoadCartAndTypeChEvent extends CheckoutEvent {
  LoadCartAndTypeChEvent({this.type});

  final CheckoutType type;
}

class CheckoutTypeSelectedChEvent extends CheckoutEvent {
  CheckoutTypeSelectedChEvent({this.type});

  final CheckoutType type;
}

class NextPressedChEvent extends CheckoutEvent {}

class BackPressedChEvent extends CheckoutEvent {}

class PaymentDoneChEvent extends CheckoutEvent {}

class LoadTimeSlots extends CheckoutEvent {
  LoadTimeSlots({@required this.type});

  final CheckoutType type;
}

class DateRangeSetChEvent extends CheckoutEvent {
  DateRangeSetChEvent(this.dateRange);

  final int dateRange;
}

class TimestampSelectedChEvent extends CheckoutEvent {
  TimestampSelectedChEvent(this.timeIndex);

  final int timeIndex;
}

class LoadAddressChEvent extends CheckoutEvent {
  // LoadAddressChEvent({this.address});

  // final /*Address*/ address;
}

class AddressSelectedChEvent extends CheckoutEvent {
  AddressSelectedChEvent({this.index});

  final int index;
}

class AddressAddedChEvent extends CheckoutEvent {
  AddressAddedChEvent({this.address});

  final /*Address*/ address;
}

class GenerateBillChEvent extends CheckoutEvent {}

class ClearCartChEvent extends CheckoutEvent {}

class ClearAPIErrorChEvent extends CheckoutEvent {}
