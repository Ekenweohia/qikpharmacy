class ShippingAddress {
  String? shippingAddressId;
  String? name;
  String? phoneNumber;
  String? address;
  String? country;
  String? city;
  String? zipCode;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  ShippingAddress(
      {this.shippingAddressId,
        this.name,
        this.phoneNumber,
        this.address,
        this.country,
        this.city,
        this.zipCode,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    shippingAddressId = json['shippingAddressId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    zipCode = json['zipCode'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shippingAddressId'] = shippingAddressId;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['country'] = country;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['isDefault'] = isDefault;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}