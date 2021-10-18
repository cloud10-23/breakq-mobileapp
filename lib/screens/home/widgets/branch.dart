import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/stores.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BranchSelectorBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _stores = getIt.get<AppGlobals>().stores;
    return CartHeading(
      title: "Select branch",
      isCaps: true,
      children: List.generate(
        _stores.length,
        (index) => ListTile(
          leading: Icon(
            FontAwesome5Solid.store,
            size: 18.0,
            color: kBlack,
          ),
          minVerticalPadding: 10.0,
          title: Text(_stores[index].branchName,
              style: Theme.of(context).textTheme.bodyText1.w700),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: kPaddingS),
            child: Text(
                "${_stores[index].branchName}, " + //${_stores[index].branchStore}, " +
                    "${_stores[index].city}, ${_stores[index].state}," +
                    " ${_stores[index].country}, ${_stores[index].pinCode}",
                style: Theme.of(context).textTheme.caption.w600),
          ),
          trailing: Icon(
            Feather.arrow_right_circle,
            size: 16.0,
            color: kBlack,
          ),
          onTap: () {
            getIt.get<AppGlobals>().selectedStore = _stores[index];
            BlocProvider.of<HomeBloc>(context).add(BranchSelectedHomeEvent());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class BranchSelectorScreen extends StatefulWidget {
  @override
  _BranchSelectorScreenState createState() => _BranchSelectorScreenState();
}

class _BranchSelectorScreenState extends State<BranchSelectorScreen> {
  final _stores = getIt.get<AppGlobals>().stores;
  Store selectedStore;
  @override
  void initState() {
    super.initState();
    if (_stores != null && _stores.isNotEmpty) selectedStore = _stores[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: kWhite),
        actionsIconTheme: IconThemeData(color: kWhite),
        backgroundColor: kBlue,
        title: Row(
          children: [
            Spacer(),
            Image(
              image: AssetImage(AssetImages.bq_icon_alt),
              height: 30,
            ),
            SizedBox(width: 5),
            Text(
              "BreakQ",
              style: Theme.of(context).textTheme.headline5.w700.white,
            ),
            Spacer(),
          ],
        ),
      ),
      backgroundColor: kWhite,
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: <Widget>[
                Container(
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
                SizedBox(height: 20),
                CustomTitle(title: "Please select a branch"),
                SizedBox(height: 50),
              ] +
              List.generate(
                _stores.length,
                (index) => ListTile(
                  leading: Icon(
                    FontAwesome5Solid.store,
                    size: 18.0,
                    color: kBlack,
                  ),
                  minVerticalPadding: 10.0,
                  title: Text(_stores[index].branchName,
                      style: Theme.of(context).textTheme.bodyText1.w700),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: kPaddingS),
                    child: Text(
                        "${_stores[index].branchName}, " + //${_stores[index].branchStore}, " +
                            "${_stores[index].city}, ${_stores[index].state}," +
                            " ${_stores[index].country}, ${_stores[index].pinCode}",
                        style: Theme.of(context).textTheme.caption.w600),
                  ),
                  trailing: Radio(
                    value: _stores[index],
                    groupValue: selectedStore,
                    onChanged: (value) => setState(() {
                      selectedStore = _stores[index];
                    }),
                  ),
                  onTap: () => setState(() {
                    selectedStore = _stores[index];
                  }),
                ),
              ),
        ),
      ),
      bottomNavigationBar: ThemeButton(
        text: "Proceed",
        onPressed: () {
          getIt.get<AppGlobals>().selectedStore = selectedStore;
          BlocProvider.of<HomeBloc>(context).add(BranchSelectedHomeEvent());
        },
      ),
    );
  }
}
