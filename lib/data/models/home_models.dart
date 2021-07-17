import 'package:breakq/configs/api_urls.dart';

class DealsModel {
  DealsModel({
    this.id,
    this.name,
    this.value,
    this.description,
    this.image,
  });

  factory DealsModel.fromJson(Map<String, dynamic> json) {
    final String _image = (apiBaseFull + (json['image'] as String)) ?? '';
    return DealsModel(
      id: int.tryParse((json['dealsandOffersID'])?.toString() ?? '0') ?? 0,
      name: json['name'] as String ?? '',
      value: json['value'] as String ?? '',
      description: json['description'] as String ?? '',
      image: _image,
    );
  }

  final int id;
  final String name;
  final String value;
  final String description;
  final String image;
}
