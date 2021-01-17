import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/category_card.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/home/widgets/quick_link_buttons.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/screens/search/search.dart';
import 'package:breakq/screens/search/widgets/search_appbar.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    //   // Show the full screen indicator until we return here.
    //   return FullScreenIndicator(
    //     color: Theme.of(context).cardColor,
    //     backgroundColor: Theme.of(context).cardColor,
    //   );
    // }

    final String imageUrl = getIt.get<AppGlobals>()?.user?.photoURL;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: LoadingOverlay(
              isLoading: false,
              child: CustomScrollView(
                controller: _customScrollViewController,
                slivers: <Widget>[
                  SliverAppBar(
                    // backgroundColor: Theme.of(context).,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    primary: true,
                    centerTitle: true,
                    title: Text("BreakQ"),
                    floating: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: kPaddingS),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: (imageUrl != null)
                                  ? NetworkImage(imageUrl)
                                  : AssetImage(AssetImages.profileDefault),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliverAppBar(
                    primary: false,
                    pinned: true,
                    toolbarHeight: kToolbarHeight,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: SearchAppBar(),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.only(top: kPaddingS),
                    height: 150,
                    child: Swiper(
                      pagination: SwiperPagination(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      autoplay: true,
                      duration: 500,
                      autoplayDelay: 4000,
                      viewportFraction: 0.7,
                      itemBuilder: (context, index) => Card(
                        margin: EdgeInsets.all(kPaddingS),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Image(
                          image: AssetImage(AssetImages.homeOffers),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      SizedBox(height: kPaddingBtwnStrips),
                      _showQuickStart(),
                      SizedBox(height: kPaddingBtwnStrips),
                      BoldTitle(title: 'Top Offers'),
                      _showGridOfImages(2, 3),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        BoldTitle(title: 'Top Deals'),
                        Spacer(),
                        Text('View All'),
                        Icon(Icons.navigate_next),
                      ]),
                      _showHorizontalScrollImages(),
                      SizedBox(height: kPaddingBtwnStrips),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        BoldTitle(title: "Exclusive Products"),
                        Spacer(),
                        Text('View All'),
                        Icon(Icons.navigate_next),
                      ]),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: _showExclusiveProducts(),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      SizedBox(height: kPaddingBtwnStrips),
                      BoldTitle(title: 'Categories'),
                    ]),
                  ),
                  _showCategories(),
                  _endPadding(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showQuickStart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            // color: kPrimaryColor,
            child: BoldTitle(
          title: 'At home?',
        )),
        Container(
          // color: kPrimaryColor,
          height: 50 + kPaddingS * 3,
          padding: EdgeInsets.symmetric(vertical: kPaddingS),
          child: ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => QuickLinkButton(index: index)),
        ),
        Container(
          // color: kPrimaryAccentColor.withOpacity(0.3),
          height: kPaddingM,
        )
      ],
    );
  }

  Widget _showGridOfImages(int columns, int rows) {
    return Column(
      children: List.generate(
        columns,
        (colIndex) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          child: Row(
            children: List.generate(
              rows,
              (rowIndex) => Expanded(
                child: GridImage(
                  colIndex: colIndex,
                  rowIndex: rowIndex,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showHorizontalScrollImages() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          6,
          (index) => GridImage(
            rowIndex: index,
            height: 130,
            width: 150,
          ),
        ),
      ),
    );
  }

  Widget _showExclusiveProducts() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) =>
              ExclProductsCard(index: index), //TopDealsCard(index: index),
        ),
      ),
    );
  }

  Widget _showCategories() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: kPaddingL,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => CategoryCard(index: index),
        childCount: 10,
      ),
    );
  }

  Widget _endPadding() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
      ),
    );
  }
}
