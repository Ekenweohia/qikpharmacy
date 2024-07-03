import 'package:qik_pharma_mobile/core/models/models.dart';

class Cart {
  String? cartId;
  num? subTotal;
  String? createdAt;
  String? updatedAt;
  List<CartItems>? cartItems;

  Cart(
      {this.cartId,
      this.subTotal,
      this.createdAt,
      this.updatedAt,
      this.cartItems});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    subTotal = json['subTotal'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['CartItems'] != null) {
      cartItems = <CartItems>[];
      json['CartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartId'] = cartId;
    data['subTotal'] = subTotal;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (cartItems != null) {
      data['CartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  String? cartItemId;
  int? qty;
  num? price;
  num? total;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CartItems(
      {this.cartItemId,
      this.qty,
      this.price,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cartItemId'];
    qty = json['qty'];
    price = json['price'];
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['Product'] != null ? Product.fromJson(json['Product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartItemId'] = cartItemId;
    data['qty'] = qty;
    data['price'] = price;
    data['total'] = total;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (product != null) {
      data['Product'] = product!.toJson();
    }
    return data;
  }
}
