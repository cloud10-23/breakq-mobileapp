import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:breakq/data/models/search_history_model.dart';
import 'package:breakq/screens/listing/widgets/search_locations_delegate_history.dart';
import 'package:breakq/screens/listing/widgets/search_locations_delegate_result_list.dart';
import 'package:breakq/utils/text_style.dart';

class SearchProductsDelegate extends SearchDelegate<String> {
  SearchProductsDelegate({this.hintText}) : super(searchFieldLabel: hintText);

  final String hintText;

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            close(context, query);
          },
        )
      ];
    }
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchLocationsDelegateResultList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ///show suggested queries based on past queries or the current context.
    if (query.isNotEmpty) {
      return SearchLocationsDelegateResultList(query: query);
    }

    return SearchLocationsDelegateHistory(
      onQuerySelected: (SearchHistoryModel model) => query = model.query,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final bool isDark = theme.brightness == Brightness.dark;

    // if (isDark) {
    //   return theme;
    // }

    // return theme.copyWith(
    //   primaryColor: Colors.white,
    //   primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
    //   primaryColorBrightness: Brightness.light,
    //   primaryTextTheme: theme.textTheme,
    // );

    return theme.copyWith(
      primaryColor: theme.appBarTheme.color,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme:
          theme.textTheme.copyWith(headline6: theme.textTheme.headline6.white),
      cursorColor: Colors.white,
      textTheme:
          theme.textTheme.copyWith(headline6: theme.textTheme.headline6.white),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
