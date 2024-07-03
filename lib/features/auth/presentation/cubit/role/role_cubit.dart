import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/role.dart';
import 'package:qik_pharma_mobile/core/repositories/repositories.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  final RoleRepositoryImpl _roleRepository;

  RoleCubit(this._roleRepository) : super(const RoleInitial());

  Future<void> getRoles() async {
    emit(const RoleLoading());

    final roles = await _roleRepository.fetchRoles();

    if (roles.isNotEmpty) {
      emit(RoleLoaded(roles));
      return;
    }
    emit(const RoleError());
  }

  Future<String?> getUserRole() async => await _roleRepository.getUserRole();
}
