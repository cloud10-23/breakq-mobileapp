part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedHomeEvent extends HomeEvent {}
