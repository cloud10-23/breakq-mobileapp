import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';

class Base extends StatelessWidget {
  Base({this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: body,
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        floatingActionButton: ScanFloatingButtonExtended(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (Navigator.of(context).canPop())
      return !await Navigator.of(context).maybePop();
    bool exit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App?'),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('Yes',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kBlack)),
                  onPressed: () => Navigator.pop(context, true),
                ),
                OutlinedButton(
                  child: Text('No',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kBlack)),
                  onPressed: () => Navigator.pop(context, false),
                )
              ],
            ));
    return exit;
  }
}
