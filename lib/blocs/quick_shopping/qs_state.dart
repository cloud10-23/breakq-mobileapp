part of 'qs_bloc.dart';

abstract class QSState {
  @override
  String toString() => '$runtimeType';
}

class InitialQSState extends QSState {}

class SessionRefreshSuccessQSState extends QSState {
  SessionRefreshSuccessQSState(this.session);

  final QSSessionModel session;
}

class LoadFailureQSState extends QSState {}
