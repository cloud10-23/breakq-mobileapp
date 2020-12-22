import 'package:breakq/screens/home/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/bottom_bar_item_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/home.dart';
import 'package:breakq/utils/bottom_bar_items.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Creates the bottom bar items.
  List<BottomNavigationBarItem> _bottomBarItems(BuildContext context) {
    getIt.get<BottomBarItems>().clear();
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'home', icon: Icons.explore));
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'search', icon: Icons.search));

    final List<BottomNavigationBarItem> bottomBarItems =
        <BottomNavigationBarItem>[];

    for (final BottomBarItemModel item
        in getIt.get<BottomBarItems>().getItems()) {
      bottomBarItems.add(BottomNavigationBarItem(
        icon: Icon(item.icon, size: kBottomBarIconSize),
        label: '',
      ));
    }

    return bottomBarItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              HomeExploreScreen(
                  key: getIt.get<AppGlobals>().globalKeyHomeScreen),
              HomeScreen(key: getIt.get<AppGlobals>().globalKeySearchScreen),
              // const ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        key: getIt.get<AppGlobals>().globalKeyBottomBar,
        items: _bottomBarItems(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        //unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        //selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
