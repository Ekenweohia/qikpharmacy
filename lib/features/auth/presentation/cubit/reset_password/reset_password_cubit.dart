import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepositoryImpl _authRepository;
  ResetPasswordCubit(this._authRepository)
      : super(const ResetPasswordInitial());

  Future<void> sendResetPasswordEmail({required String email}) async {
    emit(const ResetEmailLoading());

    final result = await _authRepository.sendResetPasswordEmail(email: email);
    if (result != null && result) {
      emit(const ResetEmailSent());
      return;
    }

    emit(const ResetPasswordError());
  }
}
