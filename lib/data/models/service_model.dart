class ServiceModel {
  ServiceModel(
    this.id,
    this.price,
    this.duration,
    this.name,
    this.description,
  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      int.tryParse(json['id'] as String ?? '0') ?? 0,
      double.tryParse(json['price'] as String ?? '0') ?? 0.0,
      int.tryParse(json['duration'] as String ?? '0') ?? 0,
      json['product_name'] as String ?? '',
      json['description'] as String ?? '',
    );
  }

  factory ServiceModel.fromNewJson(Map<String, dynamic> json) {
    return ServiceModel(
      int.tryParse(json['service_id'] as String ?? '0') ?? 0,
      double.tryParse(json['price'] as String ?? '0') ?? 0.0,
      int.tryParse(json['duration'] as String ?? '0') ?? 0,
      json['category_name'] as String ?? '',
      json['description'] as String ?? '',
    );
  }

  final int id;
  final double price;
  final int duration;
  final String name;
  final String description;

  @override
  String toString() {
    return name;
  }
}
