import 'package:breakq/data/models/category_tab_model.dart';

class HomeSessionModel {
  HomeSessionModel({
    this.categoryTabs,
    this.isLoading,
  });

  HomeSessionModel rebuild({
    List<CategoryTabModel> categoryTabs,
    bool isLoading,
  }) {
    return HomeSessionModel(
      categoryTabs: categoryTabs ?? this.categoryTabs,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<CategoryTabModel> categoryTabs;
  final bool isLoading;
}
