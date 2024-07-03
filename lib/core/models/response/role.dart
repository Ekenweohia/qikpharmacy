class Role {
  String? roleId;
  String? name;

  Role({this.roleId, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleId'] = roleId;
    data['name'] = name;
    return data;
  }
}
