import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/button_group_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:breakq/widgets/theme_button_group.dart';
import 'package:breakq/widgets/uppercase_title.dart';

class SearchFilterDrawer extends StatefulWidget {
  @override
  _SearchFilterDrawerState createState() => _SearchFilterDrawerState();
}

class _SearchFilterDrawerState extends State<SearchFilterDrawer> {
  RangeValues _rangeValues = const RangeValues(0, 1000);
  final List<ButtonGroupModel> priceRanges = [
    ButtonGroupModel(
      id: '1',
      label: '₹0 - ₹100',
    ),
    ButtonGroupModel(
      id: '2',
      label: '₹100 - ₹500',
    ),
    ButtonGroupModel(
      id: '3',
      label: '₹500 - ₹1,000',
    ),
    ButtonGroupModel(
      id: '4',
      label: '₹1,000 - ₹5,000',
    ),
    ButtonGroupModel(
      id: '5',
      label: 'Above ₹5,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// We want a wider drawer - 85% of the screen.
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingS, vertical: kPaddingM),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 24,
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).textTheme.subtitle1.color,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Padding(padding: EdgeInsets.only(right: kPaddingS)),
                    Text(
                      L10n.of(context).searchTitleFilter,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        UppercaseTitle(
                          title: L10n.of(context).searchTitlePriceRange,
                          padding: const EdgeInsets.only(
                              top: kPaddingL, bottom: kPaddingS),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingL, bottom: kPaddingS),
                          child: Text(L10n.of(context)
                              .searchDrawerDistanceRange(
                                  _rangeValues.start.round().toString(),
                                  _rangeValues.end.round().toString())),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RangeSlider(
                          min: 0,
                          max: 1000,
                          divisions: 10,
                          values: _rangeValues,
                          activeColor: kBlue,
                          inactiveColor: Theme.of(context).highlightColor,
                          labels: RangeLabels(
                            _rangeValues.start.round().toString(),
                            _rangeValues.end.round().toString(),
                          ),

                          /// Let’s say the allowed distance can be within 0 and
                          /// 100, but you want the range to be at least 10 apart.
                          onChanged: (RangeValues values) {
                            setState(() {
                              if (values.end - values.start >= 20) {
                                _rangeValues = values;
                              } else {
                                if (_rangeValues.start == values.start) {
                                  _rangeValues = RangeValues(_rangeValues.start,
                                      _rangeValues.start + 10);
                                } else {
                                  _rangeValues = RangeValues(
                                      _rangeValues.end - 10, _rangeValues.end);
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    UppercaseTitle(
                      title: L10n.of(context).searchTitlePrice,
                      padding: const EdgeInsets.only(
                          top: kPaddingL, bottom: kPaddingL),
                    ),
                    ThemeButtonGroup(
                      buttonValues: priceRanges,
                      isUnselectable: true,
                      onChange: (ButtonGroupModel selectedButton) {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingM, vertical: kPaddingL),
                child: ThemeButton(
                  text: L10n.of(context).commonBtnApply,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(FilteredListRequestedHomeEvent());

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
