class Retailer {
  String? userId;
  String? retailerId;
  String? identityCode;
  String? companyName;
  int? companyNumber;


  Retailer({
    this.userId,
    this.retailerId,
    this.identityCode,
    this.companyName,
    this.companyNumber
  });

  Retailer.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    retailerId = json['retailerId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['retailerId'] = retailerId;
    data['identityCode'] = identityCode;
    data['companyName'] = companyName;
    data['companyNumber'] = companyNumber;
    return data;
  }
}