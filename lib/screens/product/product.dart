import 'dart:async';

import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/app_button.dart';
import 'package:breakq/widgets/sliver_app_title.dart';
import 'package:breakq/utils/text_style.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key key,
    this.productId = 0,
  }) : super(key: key);

  final int productId;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final ProductsRepository locationRepository = const ProductsRepository();

  /// The GlobalKey needed to access Scaffold widget.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductModel _location;

  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    /// Load location data.
    _location = await locationRepository.getProduct(id: widget.productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productId > 0) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).cardColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    pinned: true,
                    actions: _location != null
                        ? <Widget>[
                            IconButton(
                              icon: Icon(_isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  _isFavorited = !_isFavorited;
                                });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(_isFavorited
                                      ? L10n.of(context).commonLocationFavorited
                                      : L10n.of(context)
                                          .commonLocationUnfavorited),
                                  duration: const Duration(
                                      milliseconds: kSnackBarDurationShort),
                                ));
                              }, //_onLocation,
                            ),
                          ]
                        : null,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      // background: LocationHeader(location: _location),
                    ),
                    title: _location != null
                        ? SliverAppTitle(child: Text(_location.title))
                        : Container(),
                  ),
                  SliverToBoxAdapter(
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: kPaddingM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // LocationServices(location: _location),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _bottomBar(),
          ],
        ),
      );
    } else
      return Container();
  }

  Widget _bottomBar() {
    if (_location == null) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        color: getIt.get<AppGlobals>().isPlatformBrightnessDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.all(kPaddingM),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    // TODO
                    L10n.of(context)
                        .locationAvailableServies(_location.categoryId),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Text(
                    L10n.of(context).locationInstantConfirmation,
                    style: Theme.of(context).textTheme.subtitle1.bold,
                  ),
                ],
              ),
            ),
            AppButton(
              text: L10n.of(context).locationBtnBook,
              onPressed: () {
                Navigator.pushNamed(context, Routes.booking,
                    arguments: <String, dynamic>{'locationId': _location.id});
              },
            ),
          ],
        ),
      ),
    );
  }
}
