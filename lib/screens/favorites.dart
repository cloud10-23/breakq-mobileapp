import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/bottom_bar_items.dart';
import 'package:breakq/utils/list.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:breakq/widgets/product_list_item.dart';
import 'package:breakq/widgets/theme_button.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  /// The GlobalKey needed to animate the list.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  /// The GlobalKey needed to access Scaffold widget.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Manage state of modal progress HUD widget.
  bool _isLoading = false;
  bool _isInited = false;

  List<ProductModel> _favorites;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(L10n.of(context).favoritesTitle),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: L10n.of(context).commonTooltipRefresh,
            onPressed: () {},
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: _showFavorites(),
      ),
    );
  }

  Widget _showFavorites() {
    if (!_isInited && _favorites == null) {
      return Container();
    }

    if (_favorites.isNotNullOrEmpty) {
      return AnimatedList(
        key: _listKey,
        initialItemCount: _favorites.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return _buildItem(_favorites[index], animation);
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3 * kPaddingM),
          child: Column(
            children: <Widget>[
              Jumbotron(
                title: L10n.of(context).favoritesTitleNoResults.toUpperCase(),
                icon: Icons.favorite_border,
                padding: EdgeInsets.zero,
              ),
              Text(
                L10n.of(context).favoritesNoResults,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: kPaddingM)),
              ThemeButton(
                text: L10n.of(context).appointmentsBtnExplore,
                onPressed: () {
                  (getIt.get<AppGlobals>().globalKeyBottomBar.currentWidget
                          as BottomNavigationBar)
                      .onTap(getIt
                          .get<BottomBarItems>()
                          .getBottomBarItem('explore'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(ProductModel location, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingS, horizontal: kPaddingM),
        child: ProductListItem(
          product: location,
          viewType: ProductListItemViewType.block,
          showFavoriteButton: true,
          isFavorited: true,
          onFavoriteButtonPressed: () {
            _removeFromList(location);
          },
        ),
      ),
    );
  }

  void _clearList() {
    for (int i = _favorites.length - 1; i >= 0; i--) {
      final AnimatedListRemovedItemBuilder builder =
          (BuildContext context, Animation<double> animation) {
        return Container();
      };
      _listKey.currentState.removeItem(i, builder);
    }
  }

  void _removeFromList(ProductModel location) {
    final int removeIndex = _favorites.indexOf(location);

    _favorites.remove(location);

    // This builder is just so that the animation has something to work with
    // before it disappears from view since the original has already been
    // deleted.
    final AnimatedListRemovedItemBuilder builder =
        (BuildContext context, Animation<double> animation) {
      // A method to build the Card widget.
      return _buildItem(location, animation);
    };
    _listKey.currentState.removeItem(removeIndex, builder);

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(L10n.of(context).commonLocationUnfavorited),
      duration: const Duration(milliseconds: kSnackBarDurationShort),
    ));

    // Show jumbotron for empty list.
    if (_favorites.isEmpty) {
      setState(() {
        _isInited = false;
      });
    }
  }
}
