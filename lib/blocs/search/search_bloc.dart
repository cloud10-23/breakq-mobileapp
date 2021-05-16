import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState());
  final ProductsRepository _productRepository = ProductsRepository();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SessionInitedSearchEvent) {
      yield* _mapInitSessionEventToState(event);
    } else if (event is FilteredListRequestedSearchEvent) {
      yield* _mapFilteredEventToState(event);
    } else if (event is QuerySearchEvent) {
      yield* _mapQuerySearchEventToState(event);
    } else if (event is ListTypeChangedSearchEvent) {
      yield* _mapListTypeEventToState(event);
    } else if (event is SortOrderChangedSearchEvent) {
      yield* _mapSortOrderEventToState(event);
    }
  }

  Stream<SearchState> _mapInitSessionEventToState(
      SessionInitedSearchEvent event) async* {
    List<ToolbarOptionModel> searchSortTypes;
    List<ToolbarOptionModel> searchListTypes;
    searchSortTypes = sortTypes
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    searchListTypes = listTypes
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    yield RefreshSuccessSearchState(
      SearchSessionModel(
        searchSortTypes: searchSortTypes,
        searchListTypes: searchListTypes,
        currentSort: searchSortTypes.first, // default is the first one
        currentListType: searchListTypes.first, // default is the first one
      ),
    );
    add(FilteredListRequestedSearchEvent());
  }

  Stream<SearchState> _mapFilteredEventToState(
      FilteredListRequestedSearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      final SearchSessionModel session =
          (state as RefreshSuccessSearchState).session;

      List<Product> _products;
      if (session.query?.isNotEmpty ?? false) {
        _products = await _productRepository.getProducts(
          product: session.query,
        );
      }

      yield RefreshSuccessSearchState(session.rebuild(
        products: _products,
        isLoading: false,
      ));
    }
  }

  Stream<SearchState> _mapQuerySearchEventToState(
      QuerySearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      if (event.query.isNotEmpty) {
        final SearchSessionModel session =
            (state as RefreshSuccessSearchState).session;

        yield RefreshSuccessSearchState(session.rebuild(
          query: event.query,
          products: null,
          isLoading: true,
        ));

        add(FilteredListRequestedSearchEvent());
      }
    }
  }

  Stream<SearchState> _mapListTypeEventToState(
      ListTypeChangedSearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      final SearchSessionModel session =
          (state as RefreshSuccessSearchState).session;

      yield RefreshSuccessSearchState(session.rebuild(
        currentListType: event.newListType,
      ));
    }
  }

  Stream<SearchState> _mapSortOrderEventToState(
      SortOrderChangedSearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      final SearchSessionModel session =
          (state as RefreshSuccessSearchState).session;

      yield RefreshSuccessSearchState(session.rebuild(
        currentSort: event.newSort,
        isLoading: true,
      ));

      add(FilteredListRequestedSearchEvent());
    }
  }
}
