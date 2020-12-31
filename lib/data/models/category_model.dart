class CategoryModel {
  CategoryModel({
    this.id,
    this.title,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final String _image = json['image'] as String ?? '';
    return CategoryModel(
      id: int.tryParse((json['id'])?.toString() ?? '0') ?? 0,
      title: json['cat_name'] as String ?? '',
      image: _image,
    );
  }

  final int id;
  final String title;
  final String image;
}
