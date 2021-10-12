import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/data/models/home_session_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:breakq/data/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.cartBloc}) : super(InitialHomeState());
  final ProductsRepository _productRepository = ProductsRepository();
  final CartBloc cartBloc;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SessionInitedHomeEvent) {
      yield* _mapInitSessionHomeEventToState(event);
    } else if (event is UpdateRecentlyScannedHomeEvent) {
      yield* _mapUpdateRSHomeEventToState(event);
    }
  }

  void organiseDeals(List<DealsModel> topDeals) {
    topDeals.add(topDeals[0]);
    var temp = topDeals[2];
    topDeals[2] = topDeals[1];
    topDeals[1] = temp;

    temp = topDeals[4];
    topDeals[4] = topDeals[5];
    topDeals[5] = temp;
  }

  Stream<HomeState> _mapInitSessionHomeEventToState(
      SessionInitedHomeEvent event) async* {
    yield RefreshSuccessHomeState(HomeSessionModel(isLoading: true));

    Map<homeSections, dynamic> _homeDetails =
        await _productRepository.getHomeDetails();

    List<Product> _exclProducts =
        await _productRepository.getExclusiveProduct();

    organiseDeals(_homeDetails[homeSections.topDeals]);

    if (_homeDetails?.isEmpty ?? true)
      yield RefreshFailureHomeState();
    else
      yield RefreshSuccessHomeState(
        HomeSessionModel(
          topDeals: _homeDetails[homeSections.topDeals],
          topOffers: _homeDetails[homeSections.topOffers],
          categoryTabs: _homeDetails[homeSections.categories],
          exclusiveProducts: _exclProducts,
          recentlyScanned: [],
          isLoading: false,
        ),
      );
  }

  Stream<HomeState> _mapUpdateRSHomeEventToState(
      UpdateRecentlyScannedHomeEvent event) async* {
    if (state is RefreshSuccessHomeState) {
      yield RefreshSuccessHomeState((state as RefreshSuccessHomeState)
          .session
          .rebuild(recentlyScanned: event.recentlyScanned));
    }
  }
}
