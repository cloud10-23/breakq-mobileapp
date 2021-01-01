import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/category_card.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/home/widgets/quick_link_buttons.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
          child: ProfileScreen(),
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
                    title: Container(
                      // color: kPrimaryColor,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingS,
                        vertical: kPaddingM,
                      ),
                      height: kToolbarHeight,
                      child: Card(
                        color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                            ? Theme.of(context).accentColor
                            : Theme.of(context).cardColor,
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBoxDecorationRadius)),
                        elevation: 2,
                        child: FlatButton(
                          // color: kPrimaryAccentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  kBoxDecorationRadius / 2)),
                          onPressed: () {
                            // Switch to Search Tab
                            // if (onPressed != null) {
                            //   onPressed();
                            // }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Theme.of(context).hintColor,
                              ),
                              Spacer(),
                              Expanded(
                                flex: 9,
                                child: Text(
                                  L10n.of(context).homePlaceholderSearch,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          color: Theme.of(context).hintColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        BoldTitle(title: 'Top Deals'),
                        Spacer(),
                        Text('View All'),
                        Icon(Icons.navigate_next),
                      ]),
                      Container(height: 300, child: _showTopDeals()),
                      SizedBox(height: kPaddingBtwnStrips),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        BoldTitle(title: "Exclusive Products"),
                        Spacer(),
                        Text('View All'),
                        Icon(Icons.navigate_next),
                      ]),
                      Container(height: 225, child: _showExclusiveProducts()),
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

  Widget _showTopDeals() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) => TopDealsCard(index: index),
    );
  }

  Widget _showExclusiveProducts() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, childAspectRatio: 1.6),
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) =>
          ExclProductsCard(index: index), //TopDealsCard(index: index),
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
