import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'button_group_model.g.dart';

@JsonSerializable(createToJson: false)
class ButtonGroupModel extends Equatable {
  const ButtonGroupModel({
    this.min,
    this.max,
    this.label,
  });

  factory ButtonGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ButtonGroupModelFromJson(json);

  final String min;
  final String max;
  final String label;

  @override
  List<Object> get props => <String>[min, max];
}
