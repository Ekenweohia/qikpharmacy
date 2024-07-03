part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetEmailLoading extends ResetPasswordState {
  const ResetEmailLoading();
}

class ResetEmailSent extends ResetPasswordState {
  const ResetEmailSent();
}

class ResetPasswordError extends ResetPasswordState {
  const ResetPasswordError();
}
