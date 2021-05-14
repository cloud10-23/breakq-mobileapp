part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  @override
  String toString() => '$runtimeType';
}

class InitialHomeState extends HomeState {}

class RefreshSuccessHomeState extends HomeState {
  RefreshSuccessHomeState(this.session);

  final HomeSessionModel session;
}

class RefreshFailureHomeState extends HomeState {}
