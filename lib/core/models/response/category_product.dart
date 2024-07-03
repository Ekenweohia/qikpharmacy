import 'package:qik_pharma_mobile/core/models/models.dart';

class CategoryProducts {
  String? productCategoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Product>? products;

  CategoryProducts({
    this.productCategoryId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  CategoryProducts.fromJson(Map<String, dynamic> json) {
    productCategoryId = json['productCategoryId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Products'] != null) {
      products = <Product>[];
      json['Products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCategoryId'] = productCategoryId;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
