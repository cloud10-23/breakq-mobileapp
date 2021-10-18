import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/data/models/home_session_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/home/base.dart';
import 'package:breakq/screens/home/widgets/branch.dart';
import 'package:breakq/screens/home/widgets/category_card.dart';
import 'package:breakq/screens/home/widgets/errorPage.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/home/widgets/quick_link_buttons.dart';
import 'package:breakq/screens/search/widgets/search_appbar.dart';
import 'package:breakq/screens/splash.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _customScrollViewController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, HomeState state) {
      if (getIt.get<AppGlobals>().selectedStore?.branchName == null)
        return BranchSelectorScreen();

      if (state is RefreshSuccessHomeState) {
        if (!(state?.session?.isLoading ?? true)) {
          HomeSessionModel _session = state.session;
          final List<DealsModel> _topDeals = _session.topDeals;
          // final List<DealsModel> _topOffers = _session.topOffers;
          final List<CategoryTabModel> categoryTabs = _session.categoryTabs;
          final List<Product> _exclProducts = _session.exclusiveProducts;
          final List<Product> _recentlyScanned = _session.recentlyScanned;
          final List<Product> _recentlyOrdered = _session.recentlyOrdered;
          return Base(
            categoryTabs: categoryTabs,
            body: CustomScrollView(
              controller: _customScrollViewController,
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: kWhite),
                  actionsIconTheme: IconThemeData(color: kWhite),
                  backgroundColor: kBlue,
                  title: Padding(
                    padding: const EdgeInsets.only(top: kPaddingS),
                    child: Row(
                      children: [
                        Spacer(flex: 2),
                        Image(
                          image: AssetImage(AssetImages.bq_icon_alt),
                          height: 30,
                        ),
                        Text(
                          "BreakQ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .fs16
                              .w700
                              .white,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  pinned: true,
                  actions: [
                    NotificationBell(),
                    SelectBranchIcon(),
                    CartIconButton(),
                    SizedBox(width: kPaddingM),
                  ],
                ),
                // SliverPersistentHeader(
                //   delegate: ServiceHeaderDelegate(
                //       child: SearchAppBar(), minHeight: 50, maxHeight: 50),
                //   pinned: true,
                // ),
                SliverAppBar(
                  primary: false,
                  pinned: true,
                  toolbarHeight: 50,
                  backgroundColor: kBlue,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: SearchAppBar(),
                ),
                // SliverToBoxAdapter(
                //   child: Container(color: kBlue, child: WavyHeaderImage()),
                // ),
                // SliverToBoxAdapter(
                //     child: Container(
                //   margin: EdgeInsets.only(top: kPaddingS),
                //   height: 190,
                //   child: Image(
                //     image: AssetImage(AssetImages.martIllustration),
                //     fit: BoxFit.fill,
                //   ),
                // )),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 100 / 320,
                    child: Swiper(
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          activeColor: kBlue,
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      autoplay: true,
                      duration: 500,
                      autoplayDelay: 4000,
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) => Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Image(
                          image: AssetImage(AssetImages.banner(index)),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    SizedBox(height: kPaddingBtwnStrips),
                    HomeBoldHeading(
                        title: "Top Deals",
                        icon: Icon(
                          FontAwesome5Solid.percentage,
                          color: kWhite,
                        ),
                        isBlue: true,
                        children: [
                          _showGridOfImages(_topDeals),
                        ]),
                    SizedBox(height: kPaddingBtwnStrips),
                    // HomeBoldHeading(
                    //     title: "Offers for you!",
                    //     icon: Icon(
                    //       Entypo.price_tag,
                    //     ),
                    //     children: [
                    //       _showHorizontalScrollImages(_topOffers),
                    //     ]),
                    // SizedBox(height: kPaddingBtwnStrips),
                    if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                      HomeBoldHeading(
                        title: "Recently Scanned",
                        icon: Icon(
                          MaterialCommunityIcons.barcode_scan,
                        ),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProductsHorizontalView(products: _recentlyScanned),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                      SizedBox(height: kPaddingBtwnStrips),
                    HomeBoldHeading(
                      title: "Exclusive Products",
                      icon: Icon(
                        MaterialCommunityIcons.ticket_percent,
                        color: kWhite,
                      ),
                      isBlue: true,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ProductsHorizontalView(products: _exclProducts),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(height: kPaddingBtwnStrips),
                    HomeBoldHeading(
                        title: "Categories",
                        icon: Icon(Icons.category_rounded),
                        children: [
                          _showCategories(categoryTabs),
                        ]),
                    SizedBox(height: kPaddingBtwnStrips),
                    if (_recentlyOrdered != null && _recentlyOrdered.isNotEmpty)
                      HomeBoldHeading(
                        title: "Recently Ordered",
                        icon: Icon(
                          MaterialCommunityIcons.timelapse,
                          color: kWhite,
                        ),
                        isBlue: true,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProductsHorizontalView(products: _recentlyOrdered),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                  ]),
                ),
                _endPadding(),
              ],
            ),
            bottomNavBar: _showQuickStart(),
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

  Widget _showQuickStart() {
    final double width =
        (MediaQuery.of(context).size.width - kPaddingL * 2) / 4;
    return Container(
      color: kWhite,
      height: 70,
      padding: EdgeInsets.symmetric(vertical: kPaddingS, horizontal: kPaddingL),
      child: Row(
        children: List.generate(
            4,
            (index) => QuickLinkButton(
                  index: index,
                  width: width,
                )),
      ),
    );
  }

  Widget _showGridOfImages(List<DealsModel> deals) {
    return Container(
      margin: const EdgeInsets.all(kPaddingM),
      color: kWhite,
      child: Wrap(
        children: List.generate(
          deals.length,
          (index) => GridImage(
            image: deals[index].image,
            width: (MediaQuery.of(context).size.width -
                    kPaddingM * 4 -
                    kPaddingS) /
                3,
            onPressed: () => Navigator.pushNamed(context, Routes.offerListing,
                arguments: deals[index]),
          ),
        ),
      ),
    );
  }
  // Widget _showGridOfImages(int columns, int rows) {
  //   return Container(
  //     margin: const EdgeInsets.all(kPaddingM),
  //     color: kWhite,
  //     child: Column(
  //       children: List.generate(
  //         columns,
  //         (colIndex) => Padding(
  //           padding: EdgeInsets.zero, //.symmetric(horizontal: kPaddingM),
  //           child: Row(
  //             children: List.generate(
  //               rows,
  //               (rowIndex) => Expanded(
  //                 child: GridImage(
  //                   colIndex: colIndex,
  //                   rowIndex: rowIndex,
  //                   height: 100,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _showCategories(List<CategoryTabModel> categoryTabs) {
    return Padding(
      padding: EdgeInsets.only(bottom: kPaddingM),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) =>
            CategoryCard(categoryTab: categoryTabs[index]),
        itemCount: categoryTabs.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _endPadding() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
      ),
    );
  }
}
