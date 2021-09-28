import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/screens/profile/drawer.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Base extends StatelessWidget {
  Base({@required this.body, @required this.categoryTabs, this.bottomNavBar});
  final Widget body;
  final Widget bottomNavBar;
  final List<CategoryTabModel> categoryTabs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: BlocListener<BudgetBloc, BudgetState>(
          listener: (context, state) {
            if (state is BudgetExceeded)

              /// Show the Error Dialog
              UI.showCustomDialog(
                context,
                title: "Budget Exceeded!",
                message:
                    "You have crossed the budget! You can review the cart," +
                        " ignore it or change the budget.",
                actions: [
                  TextButton(
                    child: Text(
                      "Ignore",
                      style: TextStyle(color: kBlue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text("Go to Cart"),
                    style: ElevatedButton.styleFrom(primary: kBlue),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.cart);
                    },
                  ),
                ],
              );
          },
          child: body,
        ),
        drawer: Drawer(
          child: DrawerScreen(categories: categoryTabs),
        ),
        floatingActionButton: ScanFloatingButtonExtended(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: bottomNavBar,
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
