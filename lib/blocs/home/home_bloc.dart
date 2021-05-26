import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:breakq/data/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState());
  final ProductsRepository _productRepository = ProductsRepository();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SessionInitedHomeEvent) {
      yield* _mapInitSessionHomeEventToState(event);
    }
  }

  Stream<HomeState> _mapInitSessionHomeEventToState(
      SessionInitedHomeEvent event) async* {
    yield RefreshSuccessHomeState(HomeSessionModel(isLoading: true));

    List<CategoryTabModel> categoryTabs =
        await _productRepository.getCategoryTabs();

    if (categoryTabs?.isEmpty ?? true)
      yield RefreshFailureHomeState();
    else
      yield RefreshSuccessHomeState(
        HomeSessionModel(
          categoryTabs: categoryTabs,
          isLoading: false,
        ),
      );
  }
}
