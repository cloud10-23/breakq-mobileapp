part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedHomeEvent extends HomeEvent {
  SessionInitedHomeEvent({
    this.activeSearchTab,
    this.currentSort,
    this.currentListType,
  });

  final int activeSearchTab;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModel currentListType;
}

class FilteredListRequestedHomeEvent extends HomeEvent {}

class CategoryFilteredHomeEvent extends HomeEvent {
  CategoryFilteredHomeEvent({this.activeSearchTab});

  final int activeSearchTab;
}

class BrandFilteredHomeEvent extends HomeEvent {
  BrandFilteredHomeEvent({this.activeBrandTab});

  final int activeBrandTab;
}

class ListTypeChangedHomeEvent extends HomeEvent {
  ListTypeChangedHomeEvent(this.newListType);

  final ToolbarOptionModel newListType;
}

class SortOrderChangedHomeEvent extends HomeEvent {
  SortOrderChangedHomeEvent(this.newSort);

  final ToolbarOptionModel newSort;
}
