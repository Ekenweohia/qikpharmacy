import 'package:equatable/equatable.dart';

class Region extends Equatable {
  final String? regionId;
  final String? name;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  const Region({
    this.regionId,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      regionId: json['regionId'],
      name: json['name'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionId'] = regionId;
    data['name'] = name;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props => [
        regionId,
        name,
        isActive,
        createdAt,
        updatedAt,
      ];
}
