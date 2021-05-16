part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedSearchEvent extends SearchEvent {}

class FilteredListRequestedSearchEvent extends SearchEvent {}

class QuerySearchEvent extends SearchEvent {
  QuerySearchEvent({this.query});

  final String query;
}

class ListTypeChangedSearchEvent extends SearchEvent {
  ListTypeChangedSearchEvent(this.newListType);

  final ToolbarOptionModel newListType;
}

class SortOrderChangedSearchEvent extends SearchEvent {
  SortOrderChangedSearchEvent(this.newSort);

  final ToolbarOptionModel newSort;
}
