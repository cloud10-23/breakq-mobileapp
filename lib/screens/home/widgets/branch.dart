import 'dart:convert';

import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/stores.dart';
import 'package:breakq/data/repositories/store_repository.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_preferences.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

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
  final _stores = [];
  Store selectedStore;
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    if (await AppPreferences.instance.containsKey(PreferenceKey.stores)) {
      getIt.get<AppGlobals>().stores = [];
      final List<String> stores =
          await AppPreferences.instance.getStringList(PreferenceKey.stores);

      if (stores == null || stores.length <= 0) {
        getIt.get<AppGlobals>().stores = await StoresRepository().getStores();
      } else {
        for (final s in stores)
          getIt.get<AppGlobals>().stores.add(Store.fromJson(jsonDecode(s)));
      }
    } else {
      getIt.get<AppGlobals>().stores = await StoresRepository().getStores();
    }

    setState(() {
      _stores.clear();
      _stores.addAll(getIt.get<AppGlobals>().stores);
      if (_stores != null && _stores.isNotEmpty) selectedStore = _stores[0];
    });
    final stores = <String>[];
    for (final s in getIt.get<AppGlobals>().stores)
      stores.add(jsonEncode(s.toJson()));
    await AppPreferences.instance.setStringList(PreferenceKey.stores, stores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: kWhite),
        actionsIconTheme: IconThemeData(color: kWhite),
        backgroundColor: Color(0xFF38B4FF),
      ),
      backgroundColor: kWhite,
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: <Widget>[
                Image.asset(
                  AssetImages.break_the_queue,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 20),
                CustomTitle(title: "Please select a branch"),
                SizedBox(height: 50),
              ] +
              ((_stores.isEmpty)
                  ? <Widget>[Center(child: CircularProgressIndicator())]
                  : List.generate(
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
                                  " ${_stores[index].country}, ${_stores[index].pinCode} \n" +
                                  ((_stores[index].distance != null)
                                      ? " ${_stores[index].distance?.toStringAsFixed(2) ?? ''} KM"
                                      : ''),
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
                    )),
        ),
      ),
      bottomNavigationBar: InkWell(
        child: Container(
            height: 50,
            color: kBlue,
            child: Center(
              child: Text("Proceed",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                  )),
            )),
        onTap: () {
          getIt.get<AppGlobals>().selectedStore = selectedStore;
          BlocProvider.of<HomeBloc>(context).add(BranchSelectedHomeEvent());
        },
      ),
    );
  }
}
