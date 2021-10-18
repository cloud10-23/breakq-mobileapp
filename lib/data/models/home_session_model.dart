import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/data/models/product_model.dart';

class HomeSessionModel {
  HomeSessionModel({
    this.topDeals,
    this.topOffers,
    this.categoryTabs,
    this.exclusiveProducts,
    this.recentlyScanned,
    this.recentlyOrdered,
    this.isLoading,
  });

  HomeSessionModel rebuild({
    List<DealsModel> topDeals,
    List<DealsModel> topOffers,
    List<CategoryTabModel> categoryTabs,
    List<Product> exclusiveProducts,
    List<Product> recentlyScanned,
    List<Product> recentlyOrdered,
    bool isLoading,
  }) {
    return HomeSessionModel(
      categoryTabs: categoryTabs ?? this.categoryTabs,
      topDeals: topDeals ?? this.topDeals,
      topOffers: topOffers ?? this.topOffers,
      exclusiveProducts: exclusiveProducts ?? this.exclusiveProducts,
      recentlyScanned: recentlyScanned ?? this.recentlyScanned,
      recentlyOrdered: recentlyOrdered ?? this.recentlyOrdered,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<DealsModel> topDeals;
  final List<DealsModel> topOffers;
  final List<CategoryTabModel> categoryTabs;
  final List<Product> exclusiveProducts;
  final List<Product> recentlyScanned;
  final List<Product> recentlyOrdered;
  final bool isLoading;
}
