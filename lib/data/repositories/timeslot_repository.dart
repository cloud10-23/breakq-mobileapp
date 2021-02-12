import 'dart:math';
import 'package:intl/intl.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/timetable_model.dart';

class TimeSlotRepository {
  const TimeSlotRepository();

  Future<List<TimeSlot>> getTimeSlots() async {
    final List<TimeSlot> timetables = <TimeSlot>[];
    final DateTime now = DateTime.now();
    final Random rng = Random();

    for (int days = 0; days < kReservationsDateRange; days++) {
      final DateTime dateTime = now.add(Duration(days: days));

      /// Random timetable.
      final List<int> _times = <int>[];

      /// Opening time: between 8h and 12h
      final int openingTime = rng.nextInt(4) + 8;

      /// Closing time: between 16 and 24h
      final int closingTime = rng.nextInt(8) + 16;

      for (int t = openingTime; t <= closingTime; t++) {
        final DateTime dateTimeCandidate =
            DateTime(dateTime.year, dateTime.month, dateTime.day, t, 0, 0);
        if (dateTimeCandidate.millisecondsSinceEpoch >
                now.millisecondsSinceEpoch &&
            rng.nextInt(5) > 1) {
          _times.add(
              DateTime(dateTime.year, dateTime.month, dateTime.day, t, 0, 0)
                  .millisecondsSinceEpoch);
        }
      }

      timetables.add(TimeSlot.fromJson(<String, dynamic>{
        'date': DateFormat('yyyy-MM-dd').format(now.add(Duration(days: days))),
        'times': _times,
      }));
    }

    return timetables;
  }
}
