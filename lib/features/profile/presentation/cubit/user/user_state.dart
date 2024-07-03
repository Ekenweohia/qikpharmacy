part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);
}

class UserDetailsUpdated extends UserState {
  final User user;

  const UserDetailsUpdated(this.user);
}

class UserEmailVerified extends UserState {
  final User user;

  const UserEmailVerified(this.user);
}

class UserNewEmailVerified extends UserState {
  const UserNewEmailVerified();
}

class UserPasswordChanged extends UserState {
  const UserPasswordChanged();
}

class UserLoggedOut extends UserState {
  const UserLoggedOut();
}

class UserNewEmailNotificationsStatusUpdated extends UserState {
  const UserNewEmailNotificationsStatusUpdated();
}

class UserError extends UserState {
  const UserError();
}
