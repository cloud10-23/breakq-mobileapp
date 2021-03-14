import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

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
        leading: BackButtonCircle(),
        primary: true,
        toolbarHeight: 50,
        title: Card(
          child: Row(
            children: [
              SizedBox(width: kPaddingM),
              Icon(
                Feather.search,
                size: 16.0,
              ),
              Expanded(
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: L10n.of(context).homePlaceholderSearch,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .w600
                          .copyWith(color: Colors.black45),
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
                  icon: Icon(
                    Feather.mic,
                    size: 16.0,
                  ),
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
            leading: SizedBox(
                width:
                    kPaddingL), //Image(image: AssetImage(AssetImages.maggi), height: 80),
            title: "Suggestion ${index + 1}",
            subtitle: "More details of suggestion",
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}
