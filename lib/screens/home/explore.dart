import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/home/widgets/category_card.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:breakq/screens/home/widgets/quick_link_buttons.dart';
import 'package:breakq/screens/profile/profile.dart';
import 'package:breakq/screens/search/widgets/search_appbar.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            toolbarHeight: 35,
            iconTheme: IconThemeData(color: kBlack),
            actionsIconTheme: IconThemeData(color: kBlack),
            title: Text("Home"),
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
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              CartIconButton(),
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
            toolbarHeight: kToolbarHeight,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: SearchAppBar(),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.only(top: kPaddingS),
            height: 120,
            child: Swiper(
              pagination: SwiperPagination(),
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
          )),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              SizedBox(height: kPaddingBtwnStrips),
              _showQuickStart(),
              SizedBox(height: kPaddingBtwnStrips),
              BoldTitle(title: 'Top Offers'),
              _showGridOfImages(2, 4),
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
            child: ProductsHorizontalView(),
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
    return Padding(
      padding: const EdgeInsets.all(kPaddingM),
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
    return SliverPadding(
      padding: EdgeInsets.all(kPaddingM),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => CategoryCard(index: index),
          childCount: 9,
        ),
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
