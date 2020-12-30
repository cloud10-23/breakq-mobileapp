import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeExploreScreen extends StatefulWidget {
  const HomeExploreScreen({Key key}) : super(key: key);

  @override
  HomeExploreScreenState createState() => HomeExploreScreenState();
}

class HomeExploreScreenState extends State<HomeExploreScreen> {
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
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
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
                                    : AssetImage(AssetsImages.profileDefault),
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
                          color:
                              getIt.get<AppGlobals>().isPlatformBrightnessDark
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
                            image: AssetImage(AssetsImages.homeOffers),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: Colors.black,
                onPressed: () {},
                label: Padding(
                  padding: const EdgeInsets.all(kPaddingS),
                  child: Row(
                    children: [
                      Text('Scan',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(width: kPaddingM),
                      Image(
                        image: AssetImage(AssetsImages.scan),
                        color: Colors.white,
                      ),
                    ],
                  ),
                )),
          )),
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
              itemBuilder: (context, index) {
                return Container(
                  width: 120 + kPaddingS,
                  margin: const EdgeInsets.only(bottom: 1), // for card shadow
                  padding: const EdgeInsets.only(right: kPaddingS),
                  child: Card(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingS),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Image(
                                image: AssetImage((index == 0)
                                    ? AssetsImages.quickShopping
                                    : AssetsImages.setBudget)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              (index == 0) ? 'Quick Shopping' : 'Set Budget',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
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

  Widget _showCategories() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: kPaddingL,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.listing),
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              child: Card(
                // shape: RoundedRectangleBorder(),
                clipBehavior: Clip.antiAlias,
                // shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image(
                          image: AssetImage(categories[index]['image']),
                          fit: BoxFit.fill),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      categories[index]['name'],
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
