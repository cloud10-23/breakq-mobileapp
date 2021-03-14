import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/home/widgets/category_card.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/home/widgets/quick_link_buttons.dart';
import 'package:breakq/screens/home/widgets/wavy_header_image.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/screens/search/widgets/search_appbar.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

    // final String imageUrl = getIt.get<AppGlobals>()?.user?.photoURL;
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
      primary: false,
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: CustomScrollView(
        controller: _customScrollViewController,
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            toolbarHeight: 45,
            iconTheme: IconThemeData(color: kBlack),
            actionsIconTheme: IconThemeData(color: kBlack),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            // title: Padding(
            //   padding: const EdgeInsets.only(top: kPaddingS),
            //   child: Image(
            //     image: AssetImage(AssetImages.bq_logo),
            //     height: 30,
            //   ),
            // ),
            pinned: true,
            actions: [
              IconButton(
                  icon: Icon(
                    AntDesign.bells,
                    size: 16.0,
                  ),
                  onPressed: () {}),
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
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Row(
              children: [
                SizedBox(width: 5.0),
                Flexible(flex: 1, child: SelectBranch()),
                SizedBox(width: 5.0),
                Expanded(flex: 3, child: SearchAppBar()),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(color: kBlue, child: WavyHeaderImage()),
          ),
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
            child: _showQuickStart(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: kPaddingBtwnStrips),
          ),
          SliverToBoxAdapter(
              child: HomeBoldHeading(title: "Top Offers", children: [
            Container(
              margin: EdgeInsets.only(top: kPaddingS),
              height: 120,
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
                    image: AssetImage(AssetImages.homeOffers),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ])),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              SizedBox(height: kPaddingBtwnStrips),
              HomeBoldHeading(title: "Top Deals", isBlue: true, children: [
                _showGridOfImages(2, 4),
              ]),
              SizedBox(height: kPaddingBtwnStrips),
              HomeBoldHeading(title: "Offers for you!", children: [
                _showHorizontalScrollImages(),
              ]),
              SizedBox(height: kPaddingBtwnStrips),
              HomeBoldHeading(
                title: "Exclusive Products",
                isBlue: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ProductsHorizontalView(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(height: kPaddingBtwnStrips),
              HomeBoldHeading(title: "Categories", children: [
                _showCategories(),
              ]),
            ]),
          ),
          _endPadding(),
        ],
      ),
    );
  }

  Widget _showQuickStart() {
    final double width =
        (MediaQuery.of(context).size.width - kPaddingL * 2) / 4;
    return Container(
      color: kBlue,
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

  Widget _showGridOfImages(int columns, int rows) {
    return Container(
      margin: const EdgeInsets.all(kPaddingM),
      color: kWhite,
      child: Column(
        children: List.generate(
          columns,
          (colIndex) => Padding(
            padding: EdgeInsets.zero, //.symmetric(horizontal: kPaddingM),
            child: Row(
              children: List.generate(
                rows,
                (rowIndex) => Expanded(
                  child: GridImage(
                    colIndex: colIndex,
                    rowIndex: rowIndex,
                    height: 100,
                  ),
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
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }

  Widget _showCategories() {
    return Padding(
      padding: EdgeInsets.only(bottom: kPaddingM),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) => CategoryCard(index: index),
        itemCount: 9,
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
