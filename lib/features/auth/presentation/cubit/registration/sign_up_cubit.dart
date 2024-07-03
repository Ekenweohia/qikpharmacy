import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';

import 'package:qik_pharma_mobile/barrels/repositories.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepositoryImpl _authRepository;

  SignUpCubit(this._authRepository) : super(const SignUpInitial());

  Future<void> registerUser({
    required String roleId,
    required String name,
    required String email,
    required String password,
    String? referralCode,
  }) async {
    emit(const SignUpLoading());

    UserSignUpRequest request = UserSignUpRequest(
      email: email,
      name: name,
      password: password,
      roleId: roleId,
      referralCode: referralCode,
    );

    final User user = await _authRepository.registerUser(request);

    if (user.userId != null) {
      emit(SignUpSuccessful(user));
      return;
    }

    emit(const SignUpFailed());
  }
}
