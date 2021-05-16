import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/blocs/search/search_bloc.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';

class SearchDelegateResultList extends StatefulWidget {
  const SearchDelegateResultList({Key key, this.query}) : super(key: key);

  final String query;

  @override
  _SearchDelegateResultListState createState() {
    return _SearchDelegateResultListState();
  }
}

class _SearchDelegateResultListState extends State<SearchDelegateResultList> {
  SearchBloc _searchBloc;

  List<Product> _locations;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String q = widget.query.trim();

    // _homeBloc.add(QuickSearchRequestedProductEvent(q));

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        if (state is RefreshSuccessProductState) {
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
