class AddAddressRequest {
  String? name;
  String? phoneNumber;
  String? address;
  String? country;
  String? city;
  String? zipCode;
  bool? isDefault;

  AddAddressRequest(
      {this.name,
      this.phoneNumber,
      this.address,
      this.country,
      this.city,
      this.zipCode,
      this.isDefault});

  AddAddressRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    zipCode = json['zipCode'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['country'] = country;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['isDefault'] = isDefault;
    return data;
  }
}
