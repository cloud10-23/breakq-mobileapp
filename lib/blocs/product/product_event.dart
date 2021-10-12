part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedProductEvent extends ProductEvent {
  SessionInitedProductEvent({this.categoryWithSelection, this.offer});

  final Map<CategoryModel, int> categoryWithSelection;
  final DealsModel offer;
}

class FilteredListRequestedProductEvent extends ProductEvent {}

class CategoryFilteredProductEvent extends ProductEvent {
  CategoryFilteredProductEvent({this.activeCategoryTab});

  final int activeCategoryTab;
}

class BrandFilteredProductEvent extends ProductEvent {
  BrandFilteredProductEvent({this.activeBrandTab});

  final String activeBrandTab;
}

class ListTypeChangedProductEvent extends ProductEvent {
  ListTypeChangedProductEvent(this.newListType);

  final ToolbarOptionModel newListType;
}

class SortOrderChangedProductEvent extends ProductEvent {
  SortOrderChangedProductEvent(this.newSort);

  final ToolbarOptionModel newSort;
}

class PriceFilterProductEvent extends ProductEvent {
  PriceFilterProductEvent({this.range});

  final RangeValues range;
}

class FetchRelatedProducts extends ProductEvent {
  FetchRelatedProducts({this.productCode});

  final String productCode;
}
