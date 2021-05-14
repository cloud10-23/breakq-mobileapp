class CategoryModel {
  CategoryModel({
    this.id,
    this.parentId,
    this.title,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final String _image = json['image'] as String ?? '';
    return CategoryModel(
      id: int.tryParse((json['category_Code'])?.toString() ?? '0') ?? 0,
      title: json['category_Name'] as String ?? '',
      parentId:
          int.tryParse((json['parent_Category_Code'])?.toString() ?? '0') ?? 0,
      image: _image,
    );
  }

  final int id;
  final int parentId;
  final String title;
  final String image;
}

class BrandModel {
  BrandModel({
    this.id,
    this.title,
    this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    final String _image = json['image'] as String ?? '';
    return BrandModel(
      id: json['brand_Code']?.toString() ?? '0',
      title: json['brand_Name'] as String ?? '',
      image: _image,
    );
  }

  final String id;
  final String title;
  final String image;
}
