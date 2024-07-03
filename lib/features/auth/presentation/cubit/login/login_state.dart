part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginVerified extends LoginState {
  final User user;
  const LoginVerified(this.user);
}

class LoginError extends LoginState {
  const LoginError();
}
