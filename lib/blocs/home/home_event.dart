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

class ListTypeChangedHomeEvent extends HomeEvent {
  ListTypeChangedHomeEvent(this.newListType);

  final ToolbarOptionModel newListType;
}

class SortOrderChangedHomeEvent extends HomeEvent {
  SortOrderChangedHomeEvent(this.newSort);

  final ToolbarOptionModel newSort;
}

class GenderFilterChangedHomeEvent extends HomeEvent {
  GenderFilterChangedHomeEvent(this.genderFilter);

  final ToolbarOptionModel genderFilter;
}

class NewDateRangeSelectedHomeEvent extends HomeEvent {
  NewDateRangeSelectedHomeEvent(this.dateRange);

  final int dateRange;
}

class KeywordChangedHomeEvent extends HomeEvent {
  KeywordChangedHomeEvent(this.q);

  final String q;
}

class QuickSearchRequestedHomeEvent extends HomeEvent {
  QuickSearchRequestedHomeEvent(this.q);

  final String q;
}
