import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_models.dart';

class HomeSessionModel {
  HomeSessionModel({
    this.topDeals,
    this.topOffers,
    this.categoryTabs,
    this.isLoading,
  });

  HomeSessionModel rebuild({
    List<DealsModel> topDeals,
    List<DealsModel> topOffers,
    List<CategoryTabModel> categoryTabs,
    bool isLoading,
  }) {
    return HomeSessionModel(
      categoryTabs: categoryTabs ?? this.categoryTabs,
      topDeals: topDeals ?? this.topDeals,
      topOffers: topOffers ?? this.topOffers,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<DealsModel> topDeals;
  final List<DealsModel> topOffers;
  final List<CategoryTabModel> categoryTabs;
  final bool isLoading;
}
