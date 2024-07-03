class CreateProduct {
  String? regions;
  String? productCategoryId;
  String? userId;
  String? name;
  double? price;
  int? discount;
  String? description;
  int? quantity;
  bool? isActive;
  bool? displayDiscount;
  bool? displayReviews;
  bool? needsPrescription;
  String? imageUrl;

  CreateProduct({
    this.regions,
    this.productCategoryId,
    this.userId,
    this.name,
    this.price,
    this.discount,
    this.description,
    this.quantity,
    this.isActive,
    this.displayDiscount,
    this.displayReviews,
    this.needsPrescription = false,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (regions != null) {
      data['regions[0]'] = regions!;
    }
    if (productCategoryId != null) {
      data['productCategoryId'] = productCategoryId;
    }
    if (userId != null) {
      data['userId'] = userId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (price != null) {
      data['price'] = price;
    }
    if (discount != null) {
      data['discount'] = discount;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (quantity != null) {
      data['quantity'] = quantity;
    }
    if (isActive != null) {
      data['isActive'] = isActive;
    }
    if (displayDiscount != null) {
      data['displayDiscount'] = displayDiscount;
    }
    if (displayReviews != null) {
      data['displayReviews'] = displayReviews;
    }
    if (needsPrescription != null) {
      data['needsPrescription'] = needsPrescription;
    }
    if (imageUrl != null) {
      data['imageUrl'] = imageUrl;
    }
    return data;
  }

  factory CreateProduct.fromJson(Map<String, dynamic> map) {
    return CreateProduct(
      regions: map['regions[0]'],
      productCategoryId: map['productCategoryId'],
      userId: map['userId'],
      name: map['name'],
      price: map['price'],
      discount: map['discount'],
      description: map['description'],
      quantity: map['quantity'],
      isActive: map['isActive'],
      displayDiscount: map['displayDiscount'],
      displayReviews: map['displayReviews'],
      needsPrescription: map['needsPrescription'],
      imageUrl: map['imageUrl'],
    );
  }
}
