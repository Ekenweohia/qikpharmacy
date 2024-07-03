import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/response/region.dart';

class Product {
  String? productId;
  String? name;
  String? code;
  num? price;
  int? discount;
  String? description;
  String? productImagePath;
  int? quantity;
  bool? isActive;
  bool? needsPrescription;
  bool? displayDiscount;
  bool? displayReviews;
  String? createdAt;
  String? updatedAt;
  Category? productCategory;
  List<ProductReviews>? productReviews;
  User? user;
  List<ProductRegions>? productRegions;

  Product({
    this.productId,
    this.name,
    this.code,
    this.price,
    this.discount,
    this.description,
    this.productImagePath,
    this.quantity,
    this.isActive,
    this.needsPrescription,
    this.displayDiscount,
    this.displayReviews,
    this.createdAt,
    this.updatedAt,
    this.productCategory,
    this.productReviews,
    this.user,
    this.productRegions,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    code = json['code'];
    price = json['price'];
    discount = json['discount'];
    description = json['description'];
    productImagePath = json['productImagePath'];
    quantity = json['quantity'];
    isActive = json['isActive'];
    needsPrescription = json['needsPrescription'];
    displayDiscount = json['displayDiscount'];
    displayReviews = json['displayReviews'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productCategory = json['ProductCategory'] != null
        ? Category.fromJson(json['ProductCategory'])
        : null;
    if (json['ProductReviews'] != null) {
      productReviews = <ProductReviews>[];
      json['ProductReviews'].forEach((v) {
        productReviews!.add(ProductReviews.fromJson(v));
      });
    }

    user = json['User'] != null ? User.fromJson(json['User']) : null;
    if (json['ProductRegions'] != null) {
      productRegions = <ProductRegions>[];
      json['ProductRegions'].forEach((v) {
        productRegions!.add(ProductRegions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['code'] = code;
    data['price'] = price;
    data['discount'] = discount;
    data['description'] = description;
    data['productImagePath'] = productImagePath;
    data['quantity'] = quantity;
    data['isActive'] = isActive;
    data['needsPrescription'] = needsPrescription;
    data['displayDiscount'] = displayDiscount;
    data['displayReviews'] = displayReviews;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (productCategory != null) {
      data['ProductCategory'] = productCategory!.toJson();
    }
    if (productReviews != null) {
      data['ProductReviews'] = productReviews!.map((v) => v.toJson()).toList();
    }

    if (user != null) {
      data['User'] = user!.toJson();
    }
    if (productRegions != null) {
      data['ProductRegions'] = productRegions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductReviews {
  String? productReviewId;
  String? review;
  int? rating;
  String? createdAt;
  String? updatedAt;

  ProductReviews(
      {this.productReviewId,
      this.review,
      this.rating,
      this.createdAt,
      this.updatedAt});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    productReviewId = json['productReviewId'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productReviewId'] = productReviewId;
    data['review'] = review;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductRegions {
  String? productRegionId;
  String? createdAt;
  String? updatedAt;
  Region? region;

  ProductRegions(
      {this.productRegionId, this.createdAt, this.updatedAt, this.region});

  ProductRegions.fromJson(Map<String, dynamic> json) {
    productRegionId = json['productRegionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    region = json['Region'] != null ? Region.fromJson(json['Region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productRegionId'] = productRegionId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (region != null) {
      data['Region'] = region!.toJson();
    }
    return data;
  }
}
