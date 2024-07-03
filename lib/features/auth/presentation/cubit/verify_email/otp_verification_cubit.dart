import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final AuthRepositoryImpl _authRepository;

  OtpVerificationCubit(this._authRepository)
      : super(const OtpVerificationInitial());

  void verifyEmail({required String code}) async {
    emit(const OtpVerificationLoading());

    final User user = await _authRepository.verifyEmail(code: code);
    if (user.userId != null) {
      emit(const OtpVerified());
      return;
    }

    emit(const OtpVerificationFailed());
  }

  void resendEmailVerificationCode() async {
    emit(const OtpVerificationLoading());

    await _authRepository.resendEmailVerificationCode();
    emit(const OtpResent());
  }
}
