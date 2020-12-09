import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/utils/string.dart';
import 'package:breakq/configs/constants.dart';

class SearchHeader extends SliverPersistentHeaderDelegate {
  SearchHeader({
    this.label,
    this.expandedHeight,
    this.onPressed,
  });

  final double expandedHeight;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).appBarTheme.color,
      child: Padding(
        padding: const EdgeInsets.only(
            left: kPaddingM, right: kPaddingM, top: kPaddingS),
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBoxDecorationRadius),
              ),
              elevation: 0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kFormFieldsRadius),
                ),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  }
                },
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          label == null || label.isEmpty
                              ? L10n.of(context).searchLabelQuickSearch
                              : label,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Theme.of(context).hintColor, fontSize: 18),
                        ),
                      ),
                      if (label.isNotNullOrEmpty)
                        InkWell(
                          onTap: () {
                            /// Clear the quick search.
                            BlocProvider.of<HomeBloc>(context)
                                .add(KeywordChangedHomeEvent(''));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.clear,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
