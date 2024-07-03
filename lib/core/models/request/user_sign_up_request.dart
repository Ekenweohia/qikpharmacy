class UserSignUpRequest {
  String? roleId;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? country;
  String? state;
  String? password;
  String? companyName;
  String? companyNumber;
  String? description;
  String? zipCode;
  String? gender;
  String? referralCode;

  UserSignUpRequest({
    this.roleId,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.country,
    this.state,
    this.password,
    this.companyName,
    this.companyNumber,
    this.description,
    this.zipCode,
    this.gender,
    this.referralCode,
  });

  UserSignUpRequest.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    password = json['password'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    description = json['description'];
    zipCode = json['zipCode'];
    gender = json['gender'];
    referralCode = json['referralCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roleId != null) {
      data['roleId'] = roleId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phoneNumber != null) {
      data['phoneNumber'] = phoneNumber;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (country != null) {
      data['country'] = country;
    }
    if (state != null) {
      data['state'] = state;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (companyName != null) {
      data['companyName'] = companyName;
    }
    if (companyNumber != null) {
      data['companyNumber'] = companyNumber;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (zipCode != null) {
      data['zipCode'] = zipCode;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (referralCode != null) {
      data['referralCode'] = referralCode;
    }
    return data;
  }
}
