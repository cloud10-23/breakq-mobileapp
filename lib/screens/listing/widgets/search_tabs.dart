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
    return Container(
      // color: kBlue,
      color: Theme.of(context).appBarTheme.color,
      height: kToolbarHeight,
      child: ScrollablePositionedList.builder(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
        itemCount: widget.searchTabs.length,
        itemScrollController: itemScrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final SearchTabModel item = widget.searchTabs[index];
          final bool isActive = item.id == widget.activeSearchTab;
          return Container(
            width: 120,
            child: Card(
              margin: const EdgeInsets.all(kPaddingM),
              clipBehavior: Clip.antiAlias,
              color: isActive ? kBlue : kWhite,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isActive ? kBlue : kBlackAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                key: item.globalKey,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(CategoryFilteredHomeEvent(activeSearchTab: item.id));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Image.asset(
                        categories[index]['image'],
                      ),
                    ),
                    SizedBox(width: kPaddingM),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.label,
                              style: isActive
                                  ? Theme.of(context)
                                      .textTheme
                                      .caption
                                      .fs10
                                      .bold
                                      .white
                                  : Theme.of(context)
                                      .textTheme
                                      .caption
                                      .bold
                                      .fs10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BrandTabs extends StatefulWidget {
  const BrandTabs({
    Key key,
    this.brandTabs,
    this.activeBrandTab = 0,
  }) : super(key: key);

  final List<SearchTabModel> brandTabs;
  final int activeBrandTab;

  @override
  BranchTabsState createState() => BranchTabsState();
}

class BranchTabsState extends State<BrandTabs> {
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
    return Container(
      color: kBlue,
      // color: Theme.of(context).appBarTheme.color,
      padding: const EdgeInsets.symmetric(vertical: kPaddingM),
      height: 45,
      child: ScrollablePositionedList.builder(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
        itemCount: widget.brandTabs.length,
        itemScrollController: itemScrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final SearchTabModel item = widget.brandTabs[index];
          final bool isActive = item.id == widget.activeBrandTab;
          return Container(
            key: item.globalKey,
            margin: EdgeInsets.symmetric(horizontal: kPaddingS),
            child: InputChip(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(BrandFilteredHomeEvent(activeBrandTab: item.id));
              },
              selected: isActive,
              showCheckmark: false,
              selectedColor: kWhite,
              backgroundColor: kBlue200.withOpacity(0.7),
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.label,
                    style: isActive
                        ? Theme.of(context).textTheme.caption.fs12.bold
                        : Theme.of(context).textTheme.caption.fs12.bold,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
