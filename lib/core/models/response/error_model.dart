class ErrorModel {
  bool? success;
  dynamic data;

  ErrorModel({this.success, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = data;
    return data;
  }
}
