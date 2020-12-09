import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/filter_button.dart';
import 'package:breakq/widgets/modal_bottom_sheet_item.dart';

class SearchListToolbar extends StatefulWidget {
  const SearchListToolbar({
    Key key,
    @required this.searchSortTypes,
    @required this.currentSort,
    @required this.onSortChange,
    this.onFilterTap,
  }) : super(key: key);

  final List<ToolbarOptionModel> searchSortTypes;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModelCallback onSortChange;
  final VoidCallback onFilterTap;

  @override
  _SearchListToolbarState createState() => _SearchListToolbarState();
}

class _SearchListToolbarState extends State<SearchListToolbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kPaddingM, top: kPaddingS, bottom: kPaddingS),
      color: getIt.get<AppGlobals>().isPlatformBrightnessDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).appBarTheme.color.withAlpha(50),
      child: Row(
        children: <Widget>[
          FilterButton(
            label: widget.currentSort.label,
            modalTitle: L10n.of(context).searchTitleSortOrder,
            modalItems: widget.searchSortTypes,
            selectedItem: ModalBottomSheetItem<ToolbarOptionModel>(
              text: widget.currentSort.label,
              value: widget.currentSort,
            ),
            onSelection: (ToolbarOptionModel sortModel) =>
                widget.onSortChange(sortModel),
          ),
          const Spacer(),
          IconButton(
            color: kPrimaryColor,
            padding: const EdgeInsets.only(right: kPaddingM),
            onPressed: widget.onFilterTap,
            icon: const Icon(Icons.filter_list),
            tooltip: L10n.of(context).searchTooltipFilters,
          ),
        ],
      ),
    );
  }
}
