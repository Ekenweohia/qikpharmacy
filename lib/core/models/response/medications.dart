class Medications {
  String? typeOfMedicationId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<UserTypeOfMedications>? userTypeOfMedications;

  Medications(
      {this.typeOfMedicationId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.userTypeOfMedications});

  Medications.fromJson(Map<String, dynamic> json) {
    typeOfMedicationId = json['typeOfMedicationId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['UserTypeOfMedications'] != null) {
      userTypeOfMedications = <UserTypeOfMedications>[];
      json['UserTypeOfMedications'].forEach((v) {
        userTypeOfMedications!.add(UserTypeOfMedications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeOfMedicationId'] = typeOfMedicationId;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (userTypeOfMedications != null) {
      data['UserTypeOfMedications'] =
          userTypeOfMedications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTypeOfMedications {
  String? userTypeOfMedicationId;
  String? createdAt;
  String? updatedAt;

  UserTypeOfMedications(
      {this.userTypeOfMedicationId, this.createdAt, this.updatedAt});

  UserTypeOfMedications.fromJson(Map<String, dynamic> json) {
    userTypeOfMedicationId = json['userTypeOfMedicationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userTypeOfMedicationId'] = userTypeOfMedicationId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
