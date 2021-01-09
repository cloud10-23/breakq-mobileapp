import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';

class Base extends StatelessWidget {
  Base({this.homeScreen, this.navigatorKey});
  final Widget homeScreen;
  final GlobalKey<NavigatorState> navigatorKey;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: CustomNavigator(
          homeScreen: homeScreen,
          navigatorKey: navigatorKey,
        ),
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        floatingActionButton: HybridFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (navigatorKey.currentState.canPop())
      return !await navigatorKey.currentState.maybePop();
    bool exit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App?'),
              actions: <Widget>[
                OutlineButton(
                  child: Text('Yes',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kBlack)),
                  onPressed: () => Navigator.pop(context, true),
                ),
                OutlineButton(
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
