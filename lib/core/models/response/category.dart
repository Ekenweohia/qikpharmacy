import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String? categoryId;
  final String? name;

  const Category({this.categoryId, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['productCategoryId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCategoryId'] = categoryId;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [categoryId, name];
}
