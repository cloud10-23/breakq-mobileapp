import 'package:breakq/blocs/search/search_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/data/repositories/product_repository.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/product_listing.dart';
import 'package:breakq/screens/listing/widgets/search_filter_drawer.dart';
import 'package:breakq/screens/listing/widgets/search_header.dart';
import 'package:breakq/screens/listing/widgets/search_list_toolbar.dart';
import 'package:breakq/screens/listing/widgets/tabs.dart';
import 'package:breakq/screens/search/voice_search.dart';
import 'package:breakq/screens/search/widgets/search_delegate_result_list.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

class AppSearchBar extends StatefulWidget {
  AppSearchBar({this.initialQuery});
  final String initialQuery;
  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _customScrollViewController = ScrollController();
  final _productsRepo = ProductsRepository();
  var _controller = TextEditingController();
  SearchBloc _searchBloc;
  String query;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    getIt.get<AppGlobals>().globalKeySearchTabs =
        GlobalKey<CategoryTabsState>();
    _controller.addListener(() {
      if (_controller.text != query) {
        query = _controller.text;
        _searchBloc.add(QuerySearchEvent(query: query));
      }
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
          body: CustomScrollView(
            controller: _customScrollViewController,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                expandedHeight: 45,
                backgroundColor: kBlue,
                titleSpacing: 0.0,
                primary: true,
                title: Container(
                  padding: const EdgeInsets.only(
                    left: kPaddingM,
                    right: kPaddingM,
                    bottom: kPaddingM,
                  ),
                  child: Card(
                    color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).cardColor,
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBoxDecorationRadius),
                      side: BorderSide(width: 0.5, color: Colors.black45),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: kPaddingM),
                        Icon(
                          Feather.search,
                          size: 16.0,
                          color: kBlack,
                        ),
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            controller: _controller,
                            style: Theme.of(context).textTheme.headline6.w600,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: kPaddingS),
                              hintText: L10n.of(context).homePlaceholderSearch,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .w600
                                  .black,
                              suffix: IconButton(
                                  iconSize: 18.0,
                                  onPressed: () {
                                    BlocProvider.of<SearchBloc>(context)
                                        .add(QuerySearchEvent(query: ''));
                                    _controller.clear();
                                  },
                                  icon: Icon(Feather.x_circle, color: kBlack)),
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
                            color: kBlack,
                          ),
                          onPressed: () => _voiceSearch(),
                        ),
                      ],
                    ),
                  ),
                ),
                leading: BackButtonCircle(),
                actions: [
                  Center(child: CartIconButton()),
                  SizedBox(width: 5.0),
                ],
                pinned: true, systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchHeader(
                  expandedHeight: 45,
                  child: SearchListToolbar(
                    searchSortTypes: session.searchSortTypes,
                    currentSort: session.currentSort,
                    onFilterTap: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    onSortChange: (ToolbarOptionModel newSort) {
                      _searchBloc.add(SortOrderChangedSearchEvent(newSort));
                    },
                    currentListType: session.currentListType,
                    searchListTypes: session.searchListTypes,
                    onListTypeChange: (ToolbarOptionModel newListType) =>
                        _searchBloc
                            .add(ListTypeChangedSearchEvent(newListType)),
                  ),
                ),
              ),
              ProductListing(
                currentListType: session.currentListType,
                products: session.products,
                isLoading: false,
                onNextPage: (pageKey) async => await _productsRepo.getProducts(
                  product: session.query,
                  pageNumber: pageKey.toString(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 120.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
