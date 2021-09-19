import 'package:breakq/blocs/product/offer_bloc.dart';
import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/search/widgets/search_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/no_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/data/models/product_session_model.dart';
import 'package:breakq/screens/listing/widgets/product_listing.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:breakq/utils/list.dart';
import 'package:breakq/utils/text_style.dart';

class OfferListing extends StatefulWidget {
  const OfferListing({Key key, this.offer}) : super(key: key);

  final DealsModel offer;
  @override
  OfferListingState createState() => OfferListingState();
}

class OfferListingState extends State<OfferListing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _customScrollViewController = ScrollController();

  OfferBloc _offerBloc;

  @override
  void initState() {
    super.initState();
    _offerBloc = BlocProvider.of<OfferBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _offerBloc,
      buildWhen: (ProductState previousState, ProductState currentState) {
        return currentState is InitialProductState ||
            (currentState is RefreshSuccessProductState);
      },
      builder: (BuildContext context, ProductState state) {
        if (state is InitialProductState) {
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        /// Session is initialized and/or refreshed.
        final ProductSessionModel session =
            (state as RefreshSuccessProductState).session;

        return Scaffold(
          key: _scaffoldKey,
          floatingActionButton: ScanFloatingButtonExtended(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: LoadingOverlay(
              isLoading: session.isLoading,
              child: CustomScrollView(
                controller: _customScrollViewController,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: kWhite,
                    primary: true,
                    title: Text(widget.offer.name ?? "Offers",
                        style: Theme.of(context).textTheme.headline6.fs16.w600),
                    leading: BackButtonCircle(),
                    actions: [
                      SearchIconButton(),
                      VoiceIconButton(),
                      CartIconButton(),
                      SizedBox(width: 10.0),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      if (session.products.isNotNullOrEmpty)
                        ProductListing(
                          products: session.products,
                        )
                      else
                        NoProducts(),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 120.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
