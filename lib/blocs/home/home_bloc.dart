import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meta/meta.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/product_session_model.dart';
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
    } else if (event is BrandFilteredHomeEvent) {
      yield* _mapBrandFilteredHomeEventToState(event);
    } else if (event is ListTypeChangedHomeEvent) {
      yield* _mapListTypeHomeEventToState(event);
    } else if (event is SortOrderChangedHomeEvent) {
      yield* _mapSortOrderHomeEventToState(event);
    }
  }

  Stream<HomeState> _mapInitSessionHomeEventToState(
      SessionInitedHomeEvent event) async* {
    List<BrandTabModel> categoryTabs = <BrandTabModel>[];
    List<BrandTabModel> brandTabs = <BrandTabModel>[];
    List<ToolbarOptionModel> searchSortTypes;
    List<ToolbarOptionModel> searchListTypes;
    searchSortTypes = <dynamic>[
      <String, dynamic>{
        'code': 'rating',
        'label': "Top Rated",
        'icon': Icons.star,
      },
      <String, dynamic>{
        'code': 'popularity',
        'label': "Most Popular",
        'icon': Icons.remove_red_eye,
      },
      <String, dynamic>{
        'code': 'htl',
        'label': "Price:  High-Low",
        'icon': Icons.attach_money,
      },
      <String, dynamic>{
        'code': 'lth',
        'label': "Price:  Low-High",
        'icon': Icons.attach_money,
      },
    ]
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    searchListTypes = <dynamic>[
      <String, dynamic>{
        'code': describeEnum(ProductListItemViewType.grid),
        'label': '',
        'icon': Ionicons.ios_list,
      },
      <String, dynamic>{
        'code': describeEnum(ProductListItemViewType.list),
        'label': '',
        'icon': Icons.view_comfy,
      },
      // <String, dynamic>{
      //   'code': describeEnum(ProductListItemViewType.block),
      //   'label': '',
      //   'icon': Icons.view_array,
      // },
    ]
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    /// The tabs are for Sub categories
    categoryTabs.addAll(List.generate(
        5,
        (index) => BrandTabModel.fromJson(<String, dynamic>{
              'id': index,
              'globalKey': GlobalKey(debugLabel: 'subCat-$index'),
              'label': "Sub Category",
            })));

    brandTabs.add(BrandTabModel.fromJson(<String, dynamic>{
      'id': 10,
      'globalKey': GlobalKey(debugLabel: 'brand-all'),
      'label': "All",
    }));
    brandTabs.addAll(List.generate(
        8,
        (index) => BrandTabModel.fromJson(<String, dynamic>{
              'id': index,
              'globalKey': GlobalKey(debugLabel: 'brand-$index'),
              'label': "Brand",
            })));
    yield RefreshSuccessHomeState(
      ProductSessionModel(
        // categoryTabs: categoryTabs,
        brandTabs: brandTabs,
        searchSortTypes: searchSortTypes,
        searchListTypes: searchListTypes,
        // activeCategoryTab: categoryTabs.first.id,
        currentSort: searchSortTypes.first, // default is the first one
        currentListType: searchListTypes.first, // default is the first one
        searchType: SearchType.full,
      ),
    );
    add(FilteredListRequestedHomeEvent());
  }

  Stream<HomeState> _mapFilteredHomeEventToState(
      FilteredListRequestedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final ProductSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        isLoading: true,
        searchType: SearchType.full,
      ));

      const ProductsRepository productRepository = ProductsRepository();

      List<Product> _products;

      /// This is where the tab related query for products is done
      if (session.activeCategoryTab == 0) {
        _products = await productRepository.search();
      } else {
        String subCategory = 'GROCERIES';
        // String subCategory = subCategories[session.activeSearchTab];
        _products = [];
        // await productRepository.searchCategory(subCategory: subCategory);
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
      final ProductSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        activeSearchTab: event.activeSearchTab,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapBrandFilteredHomeEventToState(
      BrandFilteredHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final ProductSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        // activeBrandTab: event.activeBrandTab,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }

  Stream<HomeState> _mapListTypeHomeEventToState(
      ListTypeChangedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      final ProductSessionModel session =
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
      final ProductSessionModel session =
          (state as RefreshSuccessHomeState).session;

      yield RefreshSuccessHomeState(session.rebuild(
        currentSort: event.newSort,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedHomeEvent());
    }
  }
  // Stream<HomeState> _mapQuickHomeEventToState(
  //     QuickSearchRequestedHomeEvent event) async* {
  //   if (state is RefreshSuccessHomeState) {
  //     if (event.q.length >= kMinimalNameQueryLength) {
  //       final SearchSessionModel session =
  //           (state as RefreshSuccessHomeState).session;

  //       yield RefreshSuccessHomeState(session.rebuild(
  //         isLoading: true,
  //         products: null,
  //         searchType: SearchType.quick,
  //       ));

  //       const ProductsRepository productRepository = ProductsRepository();

  //       List<Product> _products;

  //       _products = await productRepository.search();

  //       if (_products.isNotEmpty) {
  //         _products = _products
  //             .where((Product product) =>
  //                 product.title.toLowerCase().contains(event.q.toLowerCase()))
  //             .toList();
  //       }

  //       yield RefreshSuccessHomeState(session.rebuild(
  //         products: _products,
  //         isLoading: false,
  //         searchType: SearchType.quick,
  //       ));
  //     }
  //   }
  // }
}
