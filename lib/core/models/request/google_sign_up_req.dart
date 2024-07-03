class GoogleSignUpRequest {
  String? name;
  String? email;
  String? imagePath;

  GoogleSignUpRequest({
    required this.name,
    required this.email,
    required this.imagePath,
  });

  GoogleSignUpRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['imagePath'] = imagePath;
    return data;
  }
}
