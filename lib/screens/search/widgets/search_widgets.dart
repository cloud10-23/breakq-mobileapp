import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:flutter/material.dart';

class SearchIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => getIt.get<AppGlobals>().showSearchScreen(context));
  }
}

class VoiceIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: kBlack,
        icon: Icon(Icons.mic),
        onPressed: () => getIt.get<AppGlobals>().showVoiceScreen(context));
  }
}
