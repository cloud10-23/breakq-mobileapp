import 'package:breakq/configs/api_urls.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_models.g.dart';

@JsonSerializable(createToJson: false)
class DealsModel {
  DealsModel({
    this.id,
    this.name,
    this.value,
    this.description,
    this.image,
  });

  factory DealsModel.fromJson(Map<String, dynamic> json) =>
      _$DealsModelFromJson(json);

  @JsonKey(name: 'dealsandOffersID')
  final int id;
  final String name;
  final String value;
  final String description;
  @JsonKey(fromJson: _getImage)
  final String image;

  static String _getImage(String image) => apiBaseFull + image;
}
