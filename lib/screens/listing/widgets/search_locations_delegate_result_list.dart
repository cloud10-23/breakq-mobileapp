import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';

class SearchLocationsDelegateResultList extends StatefulWidget {
  const SearchLocationsDelegateResultList({Key key, this.query})
      : super(key: key);

  final String query;

  @override
  _SearchLocationsDelegateResultListState createState() {
    return _SearchLocationsDelegateResultListState();
  }
}

class _SearchLocationsDelegateResultListState
    extends State<SearchLocationsDelegateResultList> {
  HomeBloc _homeBloc;

  List<Product> _locations;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String q = widget.query.trim();

    _homeBloc.add(QuickSearchRequestedHomeEvent(q));

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is RefreshSuccessHomeState &&
            state.session.searchType == SearchType.quick) {
          if (state.session.isLoading) {
            return const Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          } else {
            if (q.length >= kMinimalNameQueryLength) {
              _locations = state.session.products;
              if (_locations.isEmpty) {
                return Center(
                  child: Jumbotron(
                    title: L10n.of(context).searchTitleNoResults,
                    icon: Icons.not_listed_location,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(
                    left: kPaddingM, right: kPaddingM, top: 5),
                itemCount: _locations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductListItem(
                    product: _locations[index],
                    viewType: ProductListItemViewType.search,
                    wordToStyle: q,
                  );
                },
              );
            }
          }
        }

        // if (_locations != null) {
        //   _locations.branches.clear();
        // }

        return Container();
      },
    );
  }
}
