import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/screens/search/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    Navigator.pushNamed(context, Routes.search);
    // showDialog(context: context, builder: (_) => SearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(
        right: kPaddingS,
        bottom: kPaddingM,
      ),
      height: 40,
      child: Card(
        color: getIt.get<AppGlobals>().isPlatformBrightnessDark
            ? Theme.of(context).accentColor
            : Theme.of(context).cardColor,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          side: BorderSide(width: 0.5, color: Colors.black45),
        ),
        child: TextButton(
          // color: kPrimaryAccentColor,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBoxDecorationRadius / 2)),
          ),
          onPressed: () {
            // Switch to Search Tab
            _quickSearch(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Icon(
                Feather.search,
                color: Theme.of(context).hintColor,
                size: 16,
              ),
              Spacer(),
              Expanded(
                flex: 12,
                child: Text(
                  L10n.of(context).homePlaceholderSearch,
                  style: getIt.get<AppGlobals>().captionStyle(context),
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .subtitle1
                  //     .copyWith(color: Theme.of(context).hintColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              VoiceIconButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
