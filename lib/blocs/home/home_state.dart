part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  String toString() => '$runtimeType';
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class RefreshSuccessHomeState extends HomeState {
  RefreshSuccessHomeState(this.session);

  final HomeSessionModel session;

  @override
  List<Object> get props => [session];
}

class RefreshFailureHomeState extends HomeState {
  @override
  List<Object> get props => [];
}
