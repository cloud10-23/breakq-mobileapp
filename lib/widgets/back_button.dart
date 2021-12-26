import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BackButtonCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Feather.arrow_left_circle),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
