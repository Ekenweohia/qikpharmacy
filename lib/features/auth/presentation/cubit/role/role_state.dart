part of 'role_cubit.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleInitial extends RoleState {
  const RoleInitial();
}

class RoleLoading extends RoleState {
  const RoleLoading();
}

class RoleLoaded extends RoleState {
  final List<Role> roles;
  const RoleLoaded(this.roles);
}

class RoleError extends RoleState {
  const RoleError();
}
