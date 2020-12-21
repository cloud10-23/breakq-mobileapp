import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        drawer: Drawer(),
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
                              image: AssetImage(AssetsImages.profileDefault),
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
                    toolbarHeight: kToolbarHeight + kPaddingS,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: Container(
                      color: kPrimaryColor,
                      // color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingS,
                        vertical: kPaddingM,
                      ),
                      height: 90,
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
                  // SliverPersistentHeader(
                  //   delegate: HomeHeaderPlain(
                  //     expandedHeight: 150,
                  //     onPressed: () {},
                  //     label: '',
                  //   ),
                  //   floating: true,
                  // ),
                  SliverToBoxAdapter(
                      child: SizedBox(
                    height: 180,
                    child: Swiper(
                      pagination: SwiperPagination(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      containerHeight: 250,
                      autoplay: true,
                      duration: 500,
                      autoplayDelay: 4000,
                      viewportFraction: 0.9,
                      itemBuilder: (context, index) => Image(
                        image: AssetImage(AssetsImages.homeOffers),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      _showQuickStart(),
                      BoldTitle(title: 'Categories'),
                    ]),
                  ),
                  _showCategories(),
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
      children: [
        // Container(
        //   color: kPrimaryAccentColor,
        //   padding: const EdgeInsets.symmetric(
        //       horizontal: kPaddingM, vertical: kPaddingM),
        //   child: Row(
        //     children: [
        //       Text(
        //         L10n.of(context).homeTitleHi,
        //         style: Theme.of(context).textTheme.headline6,
        //       ),
        //       SizedBox(
        //         width: 5.0,
        //       ),
        //       Text(
        //         getIt.get<AppGlobals>().user?.displayName != null
        //             ? getIt.get<AppGlobals>().user.displayName
        //             : L10n.of(context).nameGuest,
        //         // L10n.of(context).homeHeaderSubtitle,
        //         style: Theme.of(context).textTheme.headline6,
        //         // .copyWith(color: kWhite),
        //         maxLines: 1,
        //       ),
        //     ],
        //   ),
        // ),
        Container(
            color: kPrimaryAccentColor,
            child: BoldTitle(
              title: 'At home?',
            )),
        Container(
          color: kPrimaryAccentColor,
          height: 70 + kPaddingS,
          padding: EdgeInsets.only(bottom: kPaddingS),
          child: ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.only(left: kPaddingM),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 1), // for card shadow
                  padding: const EdgeInsets.only(right: kPaddingS),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image(
                            image: AssetImage((index == 0)
                                ? AssetsImages.quickShopping
                                : AssetsImages.setBudget)),
                      ),
                      Text(
                        (index == 0) ? 'Quick Shopping' : 'Set Budget',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
            color: kPrimaryAccentColor.withOpacity(0.3),
            child: BoldTitle(title: 'At the Store?')),
        //Scan to get started
        Container(
          color: kPrimaryAccentColor.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Scan to get Started',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w300),
              ),
              FloatingActionButton(
                  mini: true, onPressed: () {}, child: Icon(Icons.qr_code))
            ],
          ),
        ),
        Container(
          color: kPrimaryAccentColor.withOpacity(0.3),
          height: kPaddingM,
        )
      ],
    );
  }

  Widget _showCategories() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: kPaddingS,
        mainAxisSpacing: kPaddingM,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            height: 250,
            padding: const EdgeInsets.symmetric(
                vertical: kPaddingS, horizontal: kPaddingM),
            child: Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(25.0)),
              child: Padding(
                padding: const EdgeInsets.all(kPaddingS),
                child: Column(
                  children: [
                    Text('Category - ${index + 1}'),
                    Image(
                      image: AssetImage(AssetsImages.cat + '${index + 1}.png'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: 4,
      ),
    );
  }
}
