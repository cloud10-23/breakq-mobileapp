import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/product_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitialProductState());
  final ProductsRepository _productRepository = ProductsRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SessionInitedProductEvent) {
      yield* _mapInitSessionEventToState(event);
    } else if (event is FilteredListRequestedProductEvent) {
      yield* _mapFilteredEventToState(event);
    } else if (event is CategoryFilteredProductEvent) {
      yield* _mapCategoryFilteredEventToState(event);
    } else if (event is BrandFilteredProductEvent) {
      yield* _mapBrandFilteredEventToState(event);
    } else if (event is ListTypeChangedProductEvent) {
      yield* _mapListTypeEventToState(event);
    } else if (event is SortOrderChangedProductEvent) {
      yield* _mapSortOrderEventToState(event);
    }
  }

  Stream<ProductState> _mapInitSessionEventToState(
      SessionInitedProductEvent event) async* {
    List<CategoryTabModel> categoryTabs;
    List<BrandTabModel> brandTabs = <BrandTabModel>[];
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

    /// The tabs are for Sub categories for now only GROCERIES category works
    categoryTabs = await _productRepository.getSubCategoryTabs('GROCERIES');

    /// The tabs are for brands.. for now only GROCERIES sub-category works
    /// We add an ALL brand tab option which selects all products
    brandTabs.add(BrandTabModel.fromJson(<String, dynamic>{
      'brand': BrandModel(id: '0', title: 'All'),
      'globalKey': GlobalKey(debugLabel: 'brand-all'),
    }));
    brandTabs.addAll(await _productRepository.getBrandTabs('GROCERIES'));

    yield RefreshSuccessProductState(
      ProductSessionModel(
        categoryTabs: categoryTabs,
        brandTabs: brandTabs,
        searchSortTypes: searchSortTypes,
        searchListTypes: searchListTypes,
        activeCategoryTab: categoryTabs.first.category.id,
        currentSort: searchSortTypes.first, // default is the first one
        currentListType: searchListTypes.first, // default is the first one
        searchType: SearchType.full,
      ),
    );
    add(FilteredListRequestedProductEvent());
  }

  Stream<ProductState> _mapFilteredEventToState(
      FilteredListRequestedProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        isLoading: true,
        searchType: SearchType.full,
      ));

      List<Product> _products;

      String subCategory = 'GROCERIES';
      // String subCategory = subCategories[session.activeSearchTab];
      _products = await _productRepository.getProducts(
        category: subCategory,
        brandCode:
            (session.activeBrandTab == "0") ? null : session.activeBrandTab,
      );

      if (_products.isNotEmpty && session.q.isNotEmpty) {
        _products = _products
            .where((Product product) =>
                product.title.toLowerCase().contains(session.q.toLowerCase()))
            .toList();
      }

      yield RefreshSuccessProductState(session.rebuild(
        products: _products,
        isLoading: false,
        searchType: SearchType.full,
      ));
    }
  }

  Stream<ProductState> _mapCategoryFilteredEventToState(
      CategoryFilteredProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        activeSearchTab: event.activeSearchTab,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedProductEvent());
    }
  }

  Stream<ProductState> _mapBrandFilteredEventToState(
      BrandFilteredProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        activeBrandTab: event.activeBrandTab,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedProductEvent());
    }
  }

  Stream<ProductState> _mapListTypeEventToState(
      ListTypeChangedProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        searchType: SearchType.full,
        currentListType: event.newListType,
      ));
    }
  }

  Stream<ProductState> _mapSortOrderEventToState(
      SortOrderChangedProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        currentSort: event.newSort,
        searchType: SearchType.full,
        isLoading: true,
      ));

      add(FilteredListRequestedProductEvent());
    }
  }
  // Stream<State> _mapQuickEventToState(
  //     QuickSearchRequestedEvent event) async* {
  //   if (state is RefreshSuccessState) {
  //     if (event.q.length >= kMinimalNameQueryLength) {
  //       final SearchSessionModel session =
  //           (state as RefreshSuccessState).session;

  //       yield RefreshSuccessState(session.rebuild(
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

  //       yield RefreshSuccessState(session.rebuild(
  //         products: _products,
  //         isLoading: false,
  //         searchType: SearchType.quick,
  //       ));
  //     }
  //   }
  // }
}
