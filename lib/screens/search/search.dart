import 'package:breakq/blocs/search/search_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_session_model.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/product_listing.dart';
import 'package:breakq/screens/listing/widgets/search_filter_drawer.dart';
import 'package:breakq/screens/listing/widgets/search_list_toolbar.dart';
import 'package:breakq/screens/listing/widgets/tabs.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/no_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/list.dart';

class SearchBar extends StatefulWidget {
  SearchBar({this.initialQuery});
  final String initialQuery;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _customScrollViewController = ScrollController();
  final _productsRepo = ProductsRepository();
  var _controller = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    getIt.get<AppGlobals>().globalKeySearchTabs =
        GlobalKey<CategoryTabsState>();
    _controller.addListener(() {
      _searchBloc.add(QuerySearchEvent(query: _controller.text));
    });
    if (widget.initialQuery?.isNotEmpty ?? false) {
      _controller.text = widget.initialQuery;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  void _voiceSearch() {
    showDialog(
            context: context,
            builder: (context) => Dialog(child: VoiceSearch()),
            useRootNavigator: true)
        .then((query) {
      if (query?.isNotEmpty ?? false) {
        _controller.text = query;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previousState, currentState) {
        return currentState is InitialSearchState ||
            (currentState is RefreshSuccessSearchState);
      },
      builder: (BuildContext context, SearchState state) {
        if (state is InitialSearchState) {
          // Show the full screen indicator until we return here.
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        final SearchSessionModel session =
            (state as RefreshSuccessSearchState).session;

        return Scaffold(
          key: _scaffoldKey,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: SearchFilterDrawer(),
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
                  titleSpacing: 0.0,
                  primary: true,
                  title: Row(
                    children: [
                      SizedBox(width: kPaddingM),
                      Icon(
                        Feather.search,
                        size: 16.0,
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: _controller,
                          style: Theme.of(context).textTheme.headline6.w600,
                          decoration: InputDecoration(
                            hintText: L10n.of(context).homePlaceholderSearch,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .w600
                                .copyWith(color: Colors.black45),
                            suffix: IconButton(
                                iconSize: 18.0,
                                onPressed: () => _controller.clear(),
                                icon: Icon(Feather.x_circle)),
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      if (session.isLoading)
                        SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          Feather.mic,
                          size: 16.0,
                        ),
                        onPressed: () => _voiceSearch(),
                      ),
                    ],
                  ),
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
                              _searchBloc
                                  .add(SortOrderChangedSearchEvent(newSort));
                            },
                            currentListType: session.currentListType,
                            searchListTypes: session.searchListTypes,
                            onListTypeChange: (ToolbarOptionModel
                                    newListType) =>
                                _searchBloc.add(
                                    ListTypeChangedSearchEvent(newListType)),
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
                    CartIconButton(),
                    SizedBox(width: 10.0),
                  ],
                  floating: true,
                ),
                ProductListing(
                  currentListType: session.currentListType,
                  products: session.products,
                  isLoading: false,
                  onNextPage: (pageKey) async =>
                      await _productsRepo.getProducts(
                    product: session.query,
                    pageNumber: pageKey.toString(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 120.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
