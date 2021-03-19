import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
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
        onTap: () => getIt.get<AppGlobals>().showVoiceScreen(context));
  }
}
