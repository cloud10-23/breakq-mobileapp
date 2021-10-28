import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/data/models/timeslot_model.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';
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
    int selectedDateIndex = widget.session.selectedDateIndex;
    int selectedTimeIndex = widget.session.selectedTimeIndex;
    TimeslotModel selectedDate = widget.session.timetables[selectedDateIndex];

    return CartHeading(
      title: "Select Time Slot",
      children: <Widget>[
        Container(
          child: Container(
            height: kTimelineDateSize,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: kPaddingM),
              itemCount: widget.session.timetables.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return TimelineDate(
                  day: widget.session.timetables[index].day,
                  date: widget.session.timetables[index].date,
                  month: widget.session.timetables[index].month,
                  isSelected: selectedDateIndex == index,
                  onTap: () {
                    if (selectedDateIndex != index) {
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
        if (selectedDate != null && selectedDate.timeSchedules.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  List.generate(selectedDate.timeSchedules.length, (index) {
                final time = selectedDate.timeSchedules[index];
                // if (time.enabled)
                return _timetableItem(index, selectedTimeIndex, time.time);
                // return Container();
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

  Widget _timetableItem(int index, int selectedTime, String title) {
    return ListItem(
      leading: Padding(
        padding: const EdgeInsets.only(top: kPaddingS / 2),
        child: Radio<int>(
          activeColor: kBlue900,
          value: index,
          groupValue: selectedTime,
          onChanged: (int index) {
            selectTimestampEvent(index);
          },
        ),
      ),
      title: title,
      onPressed: () {
        selectTimestampEvent(index);
      },
    );
  }

  void selectTimestampEvent(int timeRange) {
    BlocProvider.of<CheckoutBloc>(context)
        .add(TimestampSelectedChEvent(timeRange));
  }
}

class DisplaySelectedTimeSlot extends StatelessWidget {
  DisplaySelectedTimeSlot({@required this.date, @required this.time});

  final String date;
  final String time;
  @override
  Widget build(BuildContext context) {
    return CartHeading(title: "Time Slot", children: [
      Padding(
        padding: const EdgeInsets.only(left: kPaddingL),
        child: ListItem(
          title: time,
          titleTextStyle: Theme.of(context).textTheme.subtitle1.fs16.w500,
          subtitle: date,
          subtitleTextStyle: Theme.of(context).textTheme.caption.fs14.w700,
          showBorder: false,
        ),
      ),
    ]);
  }
}
