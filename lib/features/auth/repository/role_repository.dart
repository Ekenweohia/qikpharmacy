import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';
import 'dart:convert';

import 'package:qik_pharma_mobile/core/models/models.dart';

abstract class RoleRepository {
  Future<List<Role>> fetchRoles();
  Future<String?> getUserRole();
}

class RoleRepositoryImpl with UiLoggy implements RoleRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  RoleRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<Role>> fetchRoles() async {
    List<Role> roles = [];

    try {
      final dataString = await offlineClient.getString(kRolesList);

      if (dataString != null) {
        final decodedData = jsonDecode(dataString);

        decodedData.forEach((role) => roles.add(Role.fromJson(role)));

        return roles;
      }

      final response = await dioClient.get('roles');

      if (response == null || response.runtimeType == int) {
        return roles;
      }

      final decodedData = response['data'];
      decodedData.forEach((role) => roles.add(Role.fromJson(role)));

      await offlineClient.setString(kRolesList, jsonEncode(roles));

      return roles;
    } catch (e) {
      loggy.debug(e.toString());
      return roles;
    }
  }

  @override
  Future<String?> getUserRole() async {
    final dataString = await offlineClient.getString(kUserData);

    if (dataString != null) {
      final user = User.fromJson(jsonDecode(dataString));
      return user.role?.name;
    }

    return null;
  }
}
