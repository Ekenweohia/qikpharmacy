class CompanyType {
  String? companyTypeId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Manufacturers>? manufacturers;
  List<Distributors>? distributors;

  CompanyType({
    this.companyTypeId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.manufacturers,
    this.distributors,
  });

  CompanyType.fromJson(Map<String, dynamic> json) {
    companyTypeId = json['companyTypeId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['Manufacturers'] != null) {
      manufacturers = <Manufacturers>[];
      json['Manufacturers'].forEach((v) {
        manufacturers!.add(Manufacturers.fromJson(v));
      });
    }
    if (json['Distributors'] != null) {
      distributors = <Distributors>[];
      json['Distributors'].forEach((v) {
        distributors!.add(Distributors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyTypeId'] = companyTypeId;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (manufacturers != null) {
      data['Manufacturers'] = manufacturers!.map((v) => v.toJson()).toList();
    }
    if (distributors != null) {
      data['Distributors'] = distributors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manufacturers {
  String? manufacturerId;
  String? identityCode;
  String? companyName;
  int? companyNumber;
  String? description;
  dynamic shippingAddress;
  String? createdAt;
  String? updatedAt;

  Manufacturers({
    this.manufacturerId,
    this.identityCode,
    this.companyName,
    this.companyNumber,
    this.description,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
  });

  Manufacturers.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturerId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    description = json['description'];
    shippingAddress = json['shippingAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manufacturerId'] = manufacturerId;
    data['identityCode'] = identityCode;
    data['companyName'] = companyName;
    data['companyNumber'] = companyNumber;
    data['description'] = description;
    data['shippingAddress'] = shippingAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Distributors {
  String? distributorId;
  String? identityCode;
  String? companyName;
  int? companyNumber;
  String? description;
  dynamic shippingAddress;
  String? createdAt;
  String? updatedAt;

  Distributors({
    this.distributorId,
    this.identityCode,
    this.companyName,
    this.companyNumber,
    this.description,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
  });

  Distributors.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributorId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    description = json['description'];
    shippingAddress = json['shippingAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distributorId'] = distributorId;
    data['identityCode'] = identityCode;
    data['companyName'] = companyName;
    data['companyNumber'] = companyNumber;
    data['description'] = description;
    data['shippingAddress'] = shippingAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
