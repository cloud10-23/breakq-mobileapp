import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SessionInitedHomeEvent) {
      yield* _mapInitSessionHomeEventToState(event);
    } else if (event is FilteredListRequestedHomeEvent) {
      yield* _mapFilteredHomeEventToState(event);
    } else if (event is CategoryFilteredHomeEvent) {
      yield* _mapCategoryFilteredHomeEventToState(event);
    } else if (event is ListTypeChangedHomeEvent) {
      yield* _mapListTypeHomeEventToState(event);
    } else if (event is SortOrderChangedHomeEvent) {
      yield* _mapSortOrderHomeEventToState(event);
    } else if (event is GenderFilterChangedHomeEvent) {
      yield* _mapGenderFilterHomeEventToState(event);
    } else if (event is NewDateRangeSelectedHomeEvent) {
      yield* _mapNewDateRangeHomeEventToState(event);
    } else if (event is KeywordChangedHomeEvent) {
      yield* _mapKeywordHomeEventToState(event);
    } else if (event is QuickSearchRequestedHomeEvent) {
      yield* _mapQuickHomeEventToState(event);
    }
  }

  Stream<HomeState> _mapInitSessionHomeEventToState(
      SessionInitedHomeEvent event) async* {
    yield RefreshSuccessHomeState(
      SearchSessionModel(
        currentSort: event.currentSort,
        currentListType: event.currentListType,
        activeSearchTab: event.activeSearchTab,
        searchType: SearchType.full,
      ),
    );
    add(FilteredListRequestedHomeEvent());
  }

  Stream<HomeState> _mapFilteredHomeEventToState(
      FilteredListRequestedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        isLoading: true,
        searchType: SearchType.full,
      ));

      const ProductsRepository productRepository = ProductsRepository();

      List<Product> _products;

      /// This is where the tab related query for products is done
      if (session.activeSearchTab == 0) {
        _products = await productRepository.search();
      } else {
        _products =
            await productRepository.searchCategory(id: session.activeSearchTab);
      }

      if (_products.isNotEmpty && session.q.isNotEmpty) {
        _products = _products
            .where((Product product) =>
                product.title.toLowerCase().contains(session.q.toLowerCase()))
            .toList();
      }

      yield RefreshSuccessHomeState(session.rebuild(
        products: _products,
        isLoading: false,
        searchType: SearchType.full,
      ));
    }
  }

  Stream<HomeState> _mapCategoryFilteredHomeEventToState(
      CategoryFilteredHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        activeSearchTab: event.activeSearchTab,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapListTypeHomeEventToState(
      ListTypeChangedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        searchType: SearchType.full,
        currentListType: event.newListType,
      ));
    }
  }

  Stream<HomeState> _mapSortOrderHomeEventToState(
      SortOrderChangedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        currentSort: event.newSort,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapGenderFilterHomeEventToState(
      GenderFilterChangedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        currentGenderFilter: event.genderFilter,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapNewDateRangeHomeEventToState(
      NewDateRangeSelectedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        selectedDateRange: event.dateRange,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapKeywordHomeEventToState(
      KeywordChangedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final SearchSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        q: event.q,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapQuickHomeEventToState(
      QuickSearchRequestedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      if (event.q.length >= kMinimalNameQueryLength) {
        final SearchSessionModel session =
            (state as RefreshSuccessHomeState).session;

        yield RefreshSuccessHomeState(session.rebuild(
          isLoading: true,
          products: null,
          searchType: SearchType.quick,
        ));

        const ProductsRepository productRepository = ProductsRepository();

        List<Product> _products;

        _products = await productRepository.search();

        if (_products.isNotEmpty) {
          _products = _products
              .where((Product product) =>
                  product.title.toLowerCase().contains(event.q.toLowerCase()))
              .toList();
        }

        yield RefreshSuccessHomeState(session.rebuild(
          products: _products,
          isLoading: false,
          searchType: SearchType.quick,
        ));
      }
    }
  }
}
