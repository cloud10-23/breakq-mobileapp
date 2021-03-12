import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: kWhite,
        title: Card(
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: L10n.of(context).homePlaceholderSearch,
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      Navigator.pop(context);
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(Routes.listing);
                    }),
              ),
              IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(child: VoiceSearch()),
                        useRootNavigator: true);
                  }),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM, vertical: kPaddingL),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ListItem(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Routes.listing);
            },
            leading: Image(image: AssetImage(AssetImages.maggi), height: 80),
            title: "Suggestion ${index + 1}",
            subtitle: "More details of suggestion",
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}
