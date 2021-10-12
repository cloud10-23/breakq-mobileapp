part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedHomeEvent extends HomeEvent {}

class UpdateRecentlyScannedHomeEvent extends HomeEvent {
  UpdateRecentlyScannedHomeEvent({this.recentlyScanned});
  final List<Product> recentlyScanned;
}
