import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/search_header.dart';
import 'package:breakq/screens/search/widgets/search_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/models/product_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/listing/widgets/search_filter_drawer.dart';
import 'package:breakq/screens/listing/widgets/search_list_toolbar.dart';
import 'package:breakq/screens/listing/widgets/product_listing.dart';
import 'package:breakq/screens/listing/widgets/tabs.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/utils/list.dart';
import 'package:breakq/utils/text_style.dart';

class Listing extends StatefulWidget {
  const Listing({Key key, this.category}) : super(key: key);

  final CategoryModel category;
  @override
  ListingState createState() => ListingState();
}

class ListingState extends State<Listing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _customScrollViewController = ScrollController();

  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    getIt.get<AppGlobals>().globalKeySearchTabs =
        GlobalKey<CategoryTabsState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (ProductState previousState, ProductState currentState) {
        /// Return true/false to determine whether or not to rebuild the widget
        /// with state.
        return currentState is InitialProductState ||
            (currentState is RefreshSuccessProductState);
      },
      builder: (BuildContext context, ProductState state) {
        // While the screen state is initializing we shall show a full screen
        // progress indicator and init the search session.
        if (state is InitialProductState) {
          // Show the full screen indicator until we return here.
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
          endDrawerEnableOpenDragGesture: false,
          endDrawer: SearchFilterDrawer(
            initialValue: session.range,
          ),
          floatingActionButton: ScanFloatingButtonExtended(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: CustomScrollView(
              controller: _customScrollViewController,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: kWhite,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(color: kBlack),
                  primary: true,
                  title: Text(widget.category?.title ?? "Category Name",
                      style: Theme.of(context).textTheme.headline6.fs16.w600),
                  automaticallyImplyLeading: true,
                  leading: BackButtonCircle(),
                  expandedHeight: kToolbarHeight + 35,
                  snap: true,
                  flexibleSpace: Stack(
                    children: [
                      Column(
                        children: [
                          Spacer(),
                          SearchListToolbar(
                            searchSortTypes: session.searchSortTypes,
                            currentSort: session.currentSort,
                            onFilterTap: () {
                              _scaffoldKey.currentState.openEndDrawer();
                            },
                            onSortChange: (ToolbarOptionModel newSort) {
                              _productBloc
                                  .add(SortOrderChangedProductEvent(newSort));
                            },
                            currentListType: session.currentListType,
                            searchListTypes: session.searchListTypes,
                            onListTypeChange: (ToolbarOptionModel
                                    newListType) =>
                                _productBloc.add(
                                    ListTypeChangedProductEvent(newListType)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(color: kWhite, height: kToolbarHeight),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    SearchIconButton(),
                    VoiceIconButton(),
                    CartIconButton(),
                    SizedBox(width: 10.0),
                  ],
                  floating: true,
                ),
                if (session.subCategoryTabs.isNotNullOrEmpty)
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SearchHeader(
                      expandedHeight: kToolbarHeight,
                      child: CategoryTabs(
                        activeCategoryTab: session.activeCategoryTab,
                        categoryTabs: session.subCategoryTabs,
                      ),
                    ),
                  ),
                if (session.products.isNotNullOrEmpty)
                  SliverPersistentHeader(
                    pinned: true,
                    // floating: true,
                    delegate: SearchHeader(
                      expandedHeight: 45,
                      child: BrandTabs(
                        activeBrandTab: session.activeBrandTab,
                        brandTabs: session.brandTabs,
                      ),
                    ),
                  ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    ProductListing(
                      products: session.products,
                      currentListType: session.currentListType,
                      isLoading: session.isLoading,
                    ),
                    SizedBox(height: 120.0),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
