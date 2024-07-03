import 'package:equatable/equatable.dart';

import 'package:qik_pharma_mobile/core/models/response/cart.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';

class User extends Equatable {
  final String? userId;
  final String? name;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? imagePath;
  final String? zipCode;
  final String? referralCode;
  final bool? isEmailNotificationActive;
  final bool? isConfirmed;
  final bool? isActive;
  final String? emailToken;
  final String? token;
  final String? authProvider;
  final String? createdAt;
  final String? updatedAt;
  final Wallet? wallet;
  final Cart? cart;
  final Role? role;
  final Retailer? retailer;
  final Manufacturer? manufacturer;
  final Distributor? distributor;
  final bool isTwoFA;

  const User({
    this.userId,
    this.name,
    this.email,
    this.gender,
    this.phoneNumber,
    this.address,
    this.country,
    this.state,
    this.city,
    this.imagePath,
    this.zipCode,
    this.referralCode,
    this.isEmailNotificationActive,
    this.isConfirmed,
    this.isActive,
    this.emailToken,
    this.token,
    this.authProvider,
    this.cart,
    this.createdAt,
    this.role,
    this.updatedAt,
    this.wallet,
    this.distributor,
    this.manufacturer,
    this.retailer,
    this.isTwoFA = false,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        gender,
        phoneNumber,
        address,
        country,
        state,
        city,
        imagePath,
        zipCode,
        referralCode,
        isEmailNotificationActive,
        isConfirmed,
        isActive,
        emailToken,
        token,
        wallet,
        isTwoFA,
      ];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'imagePath': imagePath,
      'zipCode': zipCode,
      'referralCode': referralCode,
      'isEmailNotificationActive': isEmailNotificationActive,
      'isConfirmed': isConfirmed,
      'isActive': isActive,
      'emailToken': emailToken,
      'token': token,
      'authProvider': authProvider,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Wallet': wallet?.toJson(),
      'cart': cart?.toJson(),
      'Role': role?.toJson(),
      'Retailer': retailer?.toJson(),
      'Manufacturer': manufacturer?.toJson(),
      'Distributor': distributor?.toJson(),
      'isTwoFA': isTwoFA,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      imagePath: map['imagePath'],
      zipCode: map['zipCode'],
      referralCode: map['referralCode'],
      isEmailNotificationActive: map['isEmailNotificationActive'],
      isConfirmed: map['isConfirmed'],
      isActive: map['isActive'],
      emailToken: map['emailToken'],
      token: map['token'],
      authProvider: map['authProvider'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      wallet: map['Wallet'] != null ? Wallet.fromJson(map['Wallet']) : null,
      cart: map['cart'] != null ? Cart.fromJson(map['cart']) : null,
      role: map['Role'] != null ? Role.fromJson(map['Role']) : null,
      retailer:
          map['Retailer'] != null ? Retailer.fromJson(map['Retailer']) : null,
      manufacturer: map['Manufacturer'] != null
          ? Manufacturer.fromJson(map['Manufacturer'])
          : null,
      distributor: map['Distributor'] != null
          ? Distributor.fromJson(map['Distributor'])
          : null,
      isTwoFA: map['isTwoFA'],
    );
  }
}

class Wallet {
  String? walletId;
  num? balance;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  List<WalletHistories>? walletHistories;
  bool? isLoggednIn;

  Wallet({
    this.walletId,
    this.balance,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isLoggednIn,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    balance = json['balance'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['WalletHistories'] != null) {
      walletHistories = <WalletHistories>[];
      json['WalletHistories'].forEach((v) {
        walletHistories!.add(WalletHistories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletId'] = walletId;
    data['balance'] = balance;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (walletHistories != null) {
      data['WalletHistories'] =
          walletHistories!.map((v) => v.toJson()).toList();
    }

    data['isLoggednIn'] = isLoggednIn;

    return data;
  }
}

class WalletHistories {
  String? walletHistoryId;
  String? type;
  num? amount;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  WalletHistories({
    this.walletHistoryId,
    this.type,
    this.amount,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  WalletHistories.fromJson(Map<String, dynamic> json) {
    walletHistoryId = json['walletHistoryId'];
    type = json['type'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletHistoryId'] = walletHistoryId;
    data['type'] = type;
    data['amount'] = amount;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Distributor {
  String? distributorId;
  String? identityCode;
  String? companyName;
  int? companyNumber;
  String? description;
  String? createdAt;
  String? updatedAt;

  Distributor(
      {this.distributorId,
      this.identityCode,
      this.companyName,
      this.companyNumber,
      this.description,
      this.createdAt,
      this.updatedAt});

  Distributor.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributorId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    description = json['description'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Manufacturer {
  String? manufacturerId;
  String? identityCode;
  String? companyName;
  int? companyNumber;
  String? description;
  String? createdAt;
  String? updatedAt;

  Manufacturer(
      {this.manufacturerId,
      this.identityCode,
      this.companyName,
      this.companyNumber,
      this.description,
      this.createdAt,
      this.updatedAt});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturerId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    description = json['description'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Retailer {
  String? retailerId;
  String? identityCode;
  String? companyName;
  int? companyNumber;
  String? createdAt;
  String? updatedAt;

  Retailer(
      {this.retailerId,
      this.identityCode,
      this.companyName,
      this.companyNumber,
      this.createdAt,
      this.updatedAt});

  Retailer.fromJson(Map<String, dynamic> json) {
    retailerId = json['retailerId'];
    identityCode = json['identityCode'];
    companyName = json['companyName'];
    companyNumber = json['companyNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retailerId'] = retailerId;
    data['identityCode'] = identityCode;
    data['companyName'] = companyName;
    data['companyNumber'] = companyNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
