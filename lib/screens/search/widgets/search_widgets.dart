import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Feather.search,
          color: kBlack,
          size: 20,
        ),
      ),
      onTap: () =>
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.search),
    ); //getIt.get<AppGlobals>().showSearchScreen(context));
  }
}

class VoiceIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Feather.mic,
            color: kBlack,
            size: 20,
          ),
        ),
        onTap: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(child: VoiceSearch()),
                    useRootNavigator: true)
                .then((query) {
              if (query != null)
                Navigator.of(context)
                    .pushNamed(Routes.search, arguments: query);
            }));
  }
}
