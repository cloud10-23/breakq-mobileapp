import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';

class SearchAppBar extends StatelessWidget {
  Future<void> _quickSearch(BuildContext context) async {
    // String queryString;
    // if (BlocProvider.of<HomeBloc>(context).state is RefreshSuccessHomeState)
    //   queryString = await showSearch(
    //     context: context,
    //     delegate: SearchProductsDelegate(hintText: 'Search for a product'),
    //     query: (BlocProvider.of<HomeBloc>(context).state
    //             as RefreshSuccessHomeState)
    //         .session
    //         .q,
    //   );

    // if (queryString == null) {
    //   BlocProvider.of<HomeBloc>(context).add(FilteredListRequestedHomeEvent());
    // } else {
    //   BlocProvider.of<HomeBloc>(context)
    //       .add(KeywordChangedHomeEvent(queryString));
    // }
    // return queryString;
    // Navigator.pushNamed(context, Routes.search);
    showDialog(context: context, child: SearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: kPrimaryColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: kPaddingS,
        vertical: kPaddingM,
      ),
      height: kToolbarHeight,
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                  ? Theme.of(context).accentColor
                  : Theme.of(context).cardColor,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBoxDecorationRadius)),
              elevation: 2,
              child: FlatButton(
                // color: kPrimaryAccentColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(kBoxDecorationRadius / 2)),
                onPressed: () {
                  // Switch to Search Tab
                  _quickSearch(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Theme.of(context).hintColor,
                    ),
                    Spacer(),
                    Expanded(
                      flex: 9,
                      child: Text(
                        L10n.of(context).homePlaceholderSearch,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).hintColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                showDialog(
                    context: context,
                    child: Dialog(child: VoiceSearch()),
                    useRootNavigator: true);
              }),
        ],
      ),
    );
  }
}
