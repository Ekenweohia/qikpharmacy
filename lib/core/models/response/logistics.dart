import 'package:qik_pharma_mobile/core/models/response/order.dart';

class Logistics {
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
  List<Order>? orders;

  Logistics({
    this.logisticsCompanyId,
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
    this.updatedAt,
    this.orders,
  });

  Logistics.fromJson(Map<String, dynamic> json) {
    logisticsCompanyId = json['logisticsCompanyId'];
    name = json['name'];
    contactPerson = json['contactPerson'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    pricePerKm = double.tryParse((json['pricePerKm']).toString());
    pricePerKg = double.tryParse((json['pricePerKg']).toString());
    trackingAvailable = json['trackingAvailable'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Orders'] != null) {
      orders = <Order>[];
      json['Orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
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
    if (orders != null) {
      data['Orders'] = orders!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
