import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/home/widgets/home_header_plane.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:breakq/screens/home/widgets/search_filter_drawer.dart';
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
        endDrawerEnableOpenDragGesture: false,
        endDrawer: SearchFilterDrawer(),
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: LoadingOverlay(
              isLoading: false,
              child: CustomScrollView(
                controller: _customScrollViewController,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: HomeHeaderPlain(
                      expandedHeight: 110,
                      onPressed: () {},
                      label: '',
                    ),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                      child: SizedBox(
                    height: 250,
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
                      BoldTitle(title: 'Quick Links'),
                      _showQuickLinks(),
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

  Widget _showQuickLinks() {
    return Container(
      height: 70,
      child: ListView.builder(
          itemCount: 4,
          padding: const EdgeInsets.only(left: kPaddingM),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 70,
              width: 150,
              margin: const EdgeInsets.only(bottom: 1), // for card shadow
              padding: const EdgeInsets.only(right: kPaddingS),
              child: Card(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  children: [
                    Image(
                        image: AssetImage((index == 0)
                            ? AssetsImages.quickShopping
                            : AssetsImages.setBudget)),
                    Expanded(
                        child: Text(
                            (index == 0) ? 'Quick Shopping' : 'Set Budget')),
                  ],
                ),
              ),
            );
          }),
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
