import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/user_log_in_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepositoryImpl _authRepository;
  LoginCubit(this._authRepository) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());

    UserLogInRequest request = UserLogInRequest(
      email: email,
      password: password,
    );

    final user = await _authRepository.loginUser(request);
    if (user.userId != null) {
      emit(LoginVerified(user));
      return;
    }

    emit(const LoginError());
  }

  Future<void> confirmPassword(String password) async {
    emit(const LoginLoading());

    final user = await _authRepository.confirmPassword(password);
    if (user.userId != null) {
      emit(LoginVerified(user));
      return;
    }

    emit(const LoginError());
  }
}
