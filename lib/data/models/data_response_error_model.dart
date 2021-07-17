import 'package:json_annotation/json_annotation.dart';

part 'data_response_error_model.g.dart';

@JsonSerializable(createToJson: false)
class DataResponseErrorModel {
  DataResponseErrorModel(
    this.code,
    this.message,
  );

  factory DataResponseErrorModel.fromJson(Map<String, dynamic> json) =>
      _$DataResponseErrorModelFromJson(json);

  final String code;
  final String message;

  @override
  String toString() => 'DataResponseErrorModel<code: $code, message: $message>';
}
