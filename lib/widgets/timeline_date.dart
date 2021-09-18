import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Vertically scrollable timeline date item.
class TimelineDate extends StatelessWidget {
  const TimelineDate({
    Key key,
    this.isSelected = false,
    @required this.day,
    @required this.date,
    @required this.month,
    @required this.onTap,
  }) : super(key: key);

  /// Is selected?
  final bool isSelected;

  /// Date range: number of days from today.
  final String day;

  final String date;

  final String month;

  /// Ontap function call.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: kTimelineDateSize,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
          color: isSelected ? kBlue900 : Theme.of(context).dividerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                day,
                style: Theme.of(context).textTheme.bodyText2.fs10.w700.copyWith(
                    color: isSelected
                        ? kWhite
                        : Theme.of(context).textTheme.bodyText2.color),
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: kNumberFontFamily,
                    color: isSelected
                        ? kWhite
                        : Theme.of(context).textTheme.headline6.color),
              ),
              Text(
                month.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2.fs10.copyWith(
                    color: isSelected
                        ? kWhite
                        : Theme.of(context).textTheme.bodyText2.color),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
