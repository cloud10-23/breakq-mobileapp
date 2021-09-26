import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/product_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';

class OfferBloc extends ProductBloc {
  OfferBloc() : super();
  final ProductsRepository _productRepository = ProductsRepository();

  @override
  Stream<ProductState> mapInitSessionEventToState(
      SessionInitedProductEvent event) async* {
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
    yield RefreshSuccessProductState(
      ProductSessionModel(
        offer: event.offer,
        searchSortTypes: searchSortTypes,
        searchListTypes: searchListTypes,
        currentSort: searchSortTypes.first, // default is the first one
        currentListType: searchListTypes[1], // default is the first one
      ),
    );
    add(FilteredListRequestedProductEvent());
  }

  @override
  Stream<ProductState> mapFilteredEventToState(
      FilteredListRequestedProductEvent event) async* {
    if (state is RefreshSuccessProductState) {
      final ProductSessionModel session =
          (state as RefreshSuccessProductState).session;

      yield RefreshSuccessProductState(session.rebuild(
        isLoading: true,
      ));

      List<Product> _products;

      _products =
          await _productRepository.getOfferProducts(offer: session.offer);

      yield RefreshSuccessProductState(session.rebuild(
        products: _products,
        isLoading: false,
      ));
    }
  }
}
