import 'package:breakq/blocs/budget/budget_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/blocs/orders/orders_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_session_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/cart_page.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/home/explore.dart';
import 'package:breakq/screens/home/widgets/branch.dart';
import 'package:breakq/screens/home/widgets/errorPage.dart';
import 'package:breakq/screens/orders/my_orders.dart';
import 'package:breakq/screens/profile/drawer.dart';
import 'package:breakq/screens/quick_links/quick_shopping.dart';
import 'package:breakq/screens/splash.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Base extends StatefulWidget {
  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> with SingleTickerProviderStateMixin {
  TabController _controller;
  final bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, HomeState state) {
      if (getIt.get<AppGlobals>().selectedStore?.branchName == null)
        return BranchSelectorScreen();

      if (state is RefreshSuccessHomeState) {
        if (!(state?.session?.isLoading ?? true)) {
          HomeSessionModel session = state.session;
          final List<CategoryTabModel> categoryTabs = session.categoryTabs;
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
                            BlocProvider.of<BudgetBloc>(context)
                                .add(BudgetIgnoreEvent());
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
                child: TabBarView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomeScreen(
                      session: session,
                    ),
                    QShoppingScreen(),
                    BlocProvider<OrdersBloc>(
                      create: (_) => OrdersBloc()
                        ..add(
                          LoadOrdersEvent(),
                        ),
                      child: MyOrders(),
                    ),
                    CartPage(),
                  ],
                ),
              ),
              drawer: Drawer(
                child: DrawerScreen(categories: categoryTabs),
              ),
              floatingActionButton: (_controller.index % 2 == 0)
                  ? ScanFloatingButtonExtended()
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: SnakeNavigationBar.color(
                key: bottomNavigationKey,
                currentIndex: (_controller.index == 3) ? 4 : _controller.index,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                height: 65,
                snakeShape: SnakeShape.rectangle,
                backgroundColor: kWhite,
                behaviour: SnakeBarBehaviour.floating,
                selectedLabelStyle:
                    Theme.of(context).textTheme.caption.fs12.w500,
                unselectedLabelStyle:
                    Theme.of(context).textTheme.caption.fs12.w500,
                onTap: (position) async {
                  if (position == 3) {
                    final _showSuccess =
                        await getIt.get<AppGlobals>().showSetBudget(context);
                    if (_showSuccess != null) {
                      final _snackBar = SnackBar(
                          content: Text("Budget has been set successfully!"));
                      ScaffoldMessenger.maybeOf(context)
                          .showSnackBar(_snackBar);
                    }
                    setState(() {
                      _controller.animateTo(0);
                    });
                    return;
                  } else if (position == 4) {
                    setState(() {
                      _controller.animateTo(3);
                    });
                    return;
                  }
                  setState(() {
                    _controller.animateTo(position);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.ios_home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(quickLinks[0]['icon']),
                      label: "Quick Shopping"),
                  BottomNavigationBarItem(
                      icon: Icon(quickLinks[3]['icon']), label: "My Orders"),
                  BottomNavigationBarItem(
                      icon: Icon(quickLinks[1]['icon']), label: "Set Budget"),
                  BottomNavigationBarItem(
                      icon: CartIconWithBadge(), label: "Cart"),
                ],
              ),
            ),
          );
        }
      } else if (state is RefreshFailureHomeState)
        return HomeErrorPage(
          tryAgain: () =>
              BlocProvider.of<HomeBloc>(context).add(SessionInitedHomeEvent()),
        );
      return SplashScreen(isPrimary: false);
    });
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (_controller.index > 0) {
      setState(() {
        _controller.animateTo(0);
      });
      return false;
    }
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
