import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';

/// General purpose empty screen.
class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key key}) : super(key: key);

  @override
  _EmptyScreenState createState() {
    return _EmptyScreenState();
  }
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          L10n.of(context).emptyTitle,
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
