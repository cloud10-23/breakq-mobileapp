part of 'ch_bloc.dart';

abstract class CheckoutEvent {
  @override
  String toString() => '$runtimeType';
}

class LoadCartChEvent extends CheckoutEvent {}

class CheckoutTypeSelectedChEvent extends CheckoutEvent {
  CheckoutTypeSelectedChEvent({this.type});

  final CheckoutType type;
}

class NextPressedChEvent extends CheckoutEvent {}

class BackPressedChEvent extends CheckoutEvent {}

class PaymentDoneChEvent extends CheckoutEvent {}

class LoadTimeSlots extends CheckoutEvent {}

class DateRangeSetChEvent extends CheckoutEvent {
  DateRangeSetChEvent(this.dateRange);

  final int dateRange;
}

class TimestampSelectedChEvent extends CheckoutEvent {
  TimestampSelectedChEvent(this.timestamp);

  final int timestamp;
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
