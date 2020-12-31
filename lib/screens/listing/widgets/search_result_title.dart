import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';

class SearchResultTitle extends StatelessWidget {
  const SearchResultTitle({
    Key key,
    @required this.locations,
    @required this.searchListTypes,
    @required this.currentListType,
    @required this.onListTypeChange,
  }) : super(key: key);

  final List<ProductModel> locations;
  final List<ToolbarOptionModel> searchListTypes;
  final ToolbarOptionModel currentListType;
  final ToolbarOptionModelCallback onListTypeChange;

  void _switchListTypeSelection(BuildContext context) {
    int index = searchListTypes
        .indexWhere((ToolbarOptionModel t) => t.code == currentListType.code);

    if (index != -1) {
      index++;
      if (index == searchListTypes.length) {
        index = 0;
      }

      onListTypeChange(searchListTypes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (locations == null || locations.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: kPaddingM),
      child: IconButton(
        color: kPrimaryColor,
        padding: const EdgeInsets.only(top: kPaddingM, right: kPaddingM),
        onPressed: () {
          _switchListTypeSelection(context);
        },
        icon: Icon(currentListType.icon),
        tooltip: L10n.of(context).searchTooltipView,
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.only(
//       left: kPaddingM, right: kPaddingM, top: kPaddingM),
//   child: Text(
//     L10n.of(context).homeTitleExplore,
//     // L10n.of(context).searchTitleResults(locations.length.toString()),
//     style: Theme.of(context).textTheme.headline5.bold,
//   ),
// ),
// const Spacer(),
