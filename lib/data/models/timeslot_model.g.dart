// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotModel _$TimeslotModelFromJson(Map<String, dynamic> json) {
  return TimeslotModel(
    day: json['day'] as String,
    date: json['date'] as String,
    month: json['month'] as String,
    scheduleDate: json['scheduleDate'] as String,
    timeSchedules: (json['timeSchedules'] as List)
        ?.map((e) => e == null
            ? null
            : TimeSchedules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

TimeSchedules _$TimeSchedulesFromJson(Map<String, dynamic> json) {
  return TimeSchedules(
    time: json['time'] as String,
    enabled: json['enabled'] as bool,
  );
}

OrderTimeSlot _$OrderTimeSlotFromJson(Map<String, dynamic> json) {
  return OrderTimeSlot(
    time: json['time'] as String,
    date: json['date'] as String,
  );
}
