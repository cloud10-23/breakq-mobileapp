import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Feather.mic),
        onPressed: () => getIt.get<AppGlobals>().showSearchScreen(context));
  }
}

class VoiceIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Icon(
          Feather.mic,
          color: kBlack,
          size: 16,
        ),
        onTap: () => getIt.get<AppGlobals>().showVoiceScreen(context));
  }
}
