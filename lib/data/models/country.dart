import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Country {
  final String name, code, dialCode, flag;

  Country({this.name, this.code, this.dialCode, this.flag});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  @override
  String toString() {
    return 'Country{name: $name, code: $code, dialCode: $dialCode}';
  }
}
