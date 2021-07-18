import 'package:json_annotation/json_annotation.dart';

part 'timeslot_model.g.dart';

@JsonSerializable(createToJson: false)
class TimeslotModel {
  final String day;
  final String date;
  final String month;
  final String scheduleDate;
  final List<TimeSchedules> timeSchedules;

  TimeslotModel(
      {this.day, this.date, this.month, this.scheduleDate, this.timeSchedules});

  factory TimeslotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeslotModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class TimeSchedules {
  String time;
  bool enabled;

  TimeSchedules({this.time, this.enabled});

  factory TimeSchedules.fromJson(Map<String, dynamic> json) =>
      _$TimeSchedulesFromJson(json);
}
