import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/search_history_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/list.dart';
import 'package:breakq/widgets/uppercase_title.dart';

/// Signature for when a tap on search history query has occurred.
typedef SearchHistoryTapCallback = void Function(SearchHistoryModel model);

class SearchDelegateHistory extends StatefulWidget {
  const SearchDelegateHistory({Key key, this.onQuerySelected})
      : super(key: key);

  final SearchHistoryTapCallback onQuerySelected;

  @override
  _SearchDelegateHistoryState createState() => _SearchDelegateHistoryState();
}

class _SearchDelegateHistoryState extends State<SearchDelegateHistory> {
  List<SearchHistoryModel> _searchHistory;

  @override
  void initState() {
    _loadHistory();
    super.initState();
  }

  Future<void> _loadHistory() async {
    const ProductsRepository locationRepository = ProductsRepository();

    _searchHistory = await locationRepository.getSearchHistory();

    if (_searchHistory.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_searchHistory.isNullOrEmpty) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UppercaseTitle(title: L10n.of(context).searchTitleRecentSearches),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingM, bottom: kPaddingL),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              children: _searchHistory.map((SearchHistoryModel item) {
                return InputChip(
                  deleteIconColor: kPrimaryColor,
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 1,
                  onPressed: () {
                    if (widget.onQuerySelected != null) {
                      widget.onQuerySelected(item);
                    }
                  },
                  label: Text(item.query),
                  onDeleted: () {
                    _searchHistory.remove(item);
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
