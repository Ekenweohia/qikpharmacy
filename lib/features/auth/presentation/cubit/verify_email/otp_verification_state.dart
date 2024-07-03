part of 'otp_verification_cubit.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {
  const OtpVerificationInitial();
}

class OtpVerificationLoading extends OtpVerificationState {
  const OtpVerificationLoading();
}

class OtpVerified extends OtpVerificationState {
  const OtpVerified();
}

class OtpResent extends OtpVerificationState {
  const OtpResent();
}

class OtpVerificationFailed extends OtpVerificationState {
  final String? message;
  const OtpVerificationFailed({this.message});
}
