part of 'ch_bloc.dart';

abstract class CheckoutState {
  @override
  String toString() => '$runtimeType';
}

class InitialChState extends CheckoutState {}

class SessionRefreshSuccessChState extends CheckoutState {
  SessionRefreshSuccessChState(this.session);

  final CheckoutSession session;
}

class LoadFailureChState extends CheckoutState {}
