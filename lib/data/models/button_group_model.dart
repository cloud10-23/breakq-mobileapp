import 'package:equatable/equatable.dart';

class ButtonGroupModel extends Equatable {
  const ButtonGroupModel({
    this.min,
    this.max,
    this.label,
  });

  factory ButtonGroupModel.fromJson(Map<String, dynamic> json) {
    return ButtonGroupModel(
      min: json['min'] as String ?? '',
      max: json['max'] as String ?? '',
      label: json['label'] as String ?? '',
    );
  }

  final String min;
  final String max;
  final String label;

  @override
  List<Object> get props => <String>[min, max];
}
