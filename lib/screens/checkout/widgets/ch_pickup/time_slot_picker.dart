import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/timetable_model.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/datetime.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/widgets/timeline_date.dart';

class TimeSlotModule extends StatefulWidget {
  TimeSlotModule({@required this.session});

  final CheckoutSession session;

  @override
  _TimeSlotModuleState createState() => _TimeSlotModuleState();
}

class _TimeSlotModuleState extends State<TimeSlotModule> {
  @override
  Widget build(BuildContext context) {
    final DateTime selectedDate =
        DateTime.now().add(Duration(days: widget.session.selectedDateRange));
    final TimeSlot timetableModel = widget.session.timetables != null
        ? widget.session.timetables.firstWhere((TimeSlot t) {
            return t.date.day == selectedDate.day &&
                t.date.month == selectedDate.month &&
                t.date.year == selectedDate.year;
          }, orElse: () => null)
        : null;

    return CartHeading(
      title: "Select Time Slot",
      children: <Widget>[
        Container(
          child: Container(
            height: kTimelineDateSize,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: kPaddingM),
              itemCount: kReservationsDateRange,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return TimelineDate(
                  dateRange: index,
                  isSelected: widget.session.selectedDateRange == index,
                  onTap: () {
                    if (widget.session.selectedDateRange != index) {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(DateRangeSetChEvent(index));
                    }
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: kPaddingL, top: kPaddingM),
          child: Text(
            'Time',
            style: Theme.of(context).textTheme.caption.fs16.w600,
          ),
        ),
        if (timetableModel != null && timetableModel.timestamps.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<ListItem>.generate(
                  timetableModel.timestamps.length, (int index) {
                return _timetableItem(timetableModel.timestamps[index],
                    widget.session.selectedTimestamp);
              }),
            ),
          )
        else
          Center(
            child: Jumbotron(
              title: "There are no slots for this date",
              icon: Icons.access_time,
              padding: EdgeInsets.zero,
              iconSize: 90,
            ),
          ),
        SizedBox(height: kPaddingL),
      ],
    );
  }

  ListItem _timetableItem(int timestamp, int selectedTimestamp) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return ListItem(
      leading: Padding(
        padding: const EdgeInsets.only(top: kPaddingS / 2),
        child: Radio<int>(
          activeColor: kBlue900,
          value: timestamp,
          groupValue: selectedTimestamp,
          onChanged: (int selected) {
            selectTimestampEvent(timestamp);
          },
        ),
      ),
      title: date.toLocalTimeString,
      onPressed: () {
        selectTimestampEvent(timestamp);
      },
    );
  }

  void selectTimestampEvent(int timestamp) {
    BlocProvider.of<CheckoutBloc>(context)
        .add(TimestampSelectedChEvent(timestamp));
  }
}

class DisplaySelectedTimeSlot extends StatelessWidget {
  DisplaySelectedTimeSlot({@required this.session});

  final CheckoutSession session;
  @override
  Widget build(BuildContext context) {
    final DateTime time =
        DateTime.fromMillisecondsSinceEpoch(session.selectedTimestamp);
    return CartHeading(title: "Time Slot", children: [
      Padding(
        padding: const EdgeInsets.only(left: kPaddingL),
        child: ListItem(
          title: time.toLocalDateTimeString,
          titleTextStyle: Theme.of(context).textTheme.subtitle1.fs16.w500,
          subtitle: time.toLocalTimeString,
          subtitleTextStyle: Theme.of(context).textTheme.caption.fs14.w700,
          showBorder: false,
        ),
      ),
    ]);
  }
}
