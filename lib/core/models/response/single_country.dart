class SingleCountry {
  int? id;
  String? countryName;
  String? countryFlagPath;
  String? apiLink;
  String? primaryKey;
  String? testKey;
  String? currency;
  String? createdAt;
  String? updatedAt;
  String? countryCurrency;

  SingleCountry({
    this.id,
    this.countryName,
    this.countryFlagPath,
    this.apiLink,
    this.primaryKey,
    this.testKey,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.countryCurrency,
  });

  SingleCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['countryName'];
    countryFlagPath = json['countryFlagPath'];
    apiLink = json['apiLink'];
    primaryKey = json['primaryKey'];
    testKey = json['testKey'];
    currency = json['currency'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    countryCurrency = json['countryCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryName'] = countryName;
    data['countryFlagPath'] = countryFlagPath;
    data['apiLink'] = apiLink;
    data['primaryKey'] = primaryKey;
    data['testKey'] = testKey;
    data['currency'] = currency;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['countryCurrency'] = countryCurrency;

    return data;
  }
}
