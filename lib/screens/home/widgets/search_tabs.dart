import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/search_tab_model.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SearchTabs extends StatefulWidget {
  const SearchTabs({
    Key key,
    this.searchTabs,
    this.activeSearchTab = 0,
  }) : super(key: key);

  final List<SearchTabModel> searchTabs;
  final int activeSearchTab;

  @override
  SearchTabsState createState() => SearchTabsState();
}

class SearchTabsState extends State<SearchTabs> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingS),
      child: Container(
        color: Theme.of(context).appBarTheme.color,
        height: 60,
        child: ScrollablePositionedList.builder(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          itemCount: widget.searchTabs.length,
          itemScrollController: itemScrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final SearchTabModel item = widget.searchTabs[index];
            final bool isActive = item.id == widget.activeSearchTab;
            return InkWell(
              key: item.globalKey,
              onTap: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(CategoryFilteredHomeEvent(activeSearchTab: item.id));
              },
              child: Container(
                //key: item.keyTabItem,
                padding: const EdgeInsets.only(
                    top: kPaddingS, left: kPaddingS, right: kPaddingS),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive
                          ? Theme.of(context).tabBarTheme.labelColor
                          : Theme.of(context).appBarTheme.color,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  item.label,
                  style: isActive
                      ? Theme.of(context).textTheme.bodyText1.bold.copyWith(
                          color: Theme.of(context).tabBarTheme.labelColor)
                      : Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context)
                              .tabBarTheme
                              .labelColor
                              .withOpacity(0.75)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
