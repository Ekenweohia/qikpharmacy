import 'package:qik_pharma_mobile/core/models/models.dart';

class Order {
  String? orderId;
  num? subTotal;
  String? status;
  int? shippingCompanyId;
  String? trackingNumber;
  String? createdAt;
  String? updatedAt;
  LogisticsCompany? logisticsCompany;
  List<OrderItems>? orderItems;

  Order(
      {this.orderId,
      this.subTotal,
      this.status,
      this.shippingCompanyId,
      this.trackingNumber,
      this.createdAt,
      this.updatedAt,
      this.logisticsCompany,
      this.orderItems});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    subTotal = json['subTotal'];
    status = json['status'];
    shippingCompanyId = json['shippingCompanyId'];
    trackingNumber = json['trackingNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    logisticsCompany = json['LogisticsCompany'] != null
        ? LogisticsCompany.fromJson(json['LogisticsCompany'])
        : null;
    if (json['OrderItems'] != null) {
      orderItems = <OrderItems>[];
      json['OrderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['subTotal'] = subTotal;
    data['status'] = status;
    data['shippingCompanyId'] = shippingCompanyId;
    data['trackingNumber'] = trackingNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (logisticsCompany != null) {
      data['LogisticsCompany'] = logisticsCompany!.toJson();
    }
    if (orderItems != null) {
      data['OrderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LogisticsCompany {
  String? logisticsCompanyId;
  String? name;
  String? contactPerson;
  String? email;
  String? phoneNumber;
  String? address;
  String? country;
  String? state;
  double? pricePerKm;
  double? pricePerKg;
  bool? trackingAvailable;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  LogisticsCompany(
      {this.logisticsCompanyId,
      this.name,
      this.contactPerson,
      this.email,
      this.phoneNumber,
      this.address,
      this.country,
      this.state,
      this.pricePerKm,
      this.pricePerKg,
      this.trackingAvailable,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  LogisticsCompany.fromJson(Map<String, dynamic> json) {
    logisticsCompanyId = json['logisticsCompanyId'];
    name = json['name'];
    contactPerson = json['contactPerson'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    pricePerKm = json['pricePerKm'];
    pricePerKg = json['pricePerKg'];
    trackingAvailable = json['trackingAvailable'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logisticsCompanyId'] = logisticsCompanyId;
    data['name'] = name;
    data['contactPerson'] = contactPerson;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['pricePerKm'] = pricePerKm;
    data['pricePerKg'] = pricePerKg;
    data['trackingAvailable'] = trackingAvailable;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class OrderItems {
  String? orderItemId;
  int? orderId;
  int? qty;
  num? price;
  num? total;
  String? createdAt;
  String? updatedAt;
  Product? product;

  OrderItems(
      {this.orderItemId,
      this.orderId,
      this.qty,
      this.price,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderItemId = json['orderItemId'];
    orderId = json['orderId'];
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
    data['orderItemId'] = orderItemId;
    data['orderId'] = orderId;
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
