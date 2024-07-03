part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];

  get user => null;
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccessful extends SignUpState {
  @override
  final User user;
  const SignUpSuccessful(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpSuccessful && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class SignUpFailed extends SignUpState {
  final String? message;
  const SignUpFailed({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpFailed && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
