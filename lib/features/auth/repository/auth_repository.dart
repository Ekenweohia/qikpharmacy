import 'package:qik_pharma_mobile/core/models/request/user_log_in_request.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';

import 'package:qik_pharma_mobile/core/models/models.dart';

abstract class AuthRepository {
  Future<User> registerUser(UserSignUpRequest request);

  Future<User> verifyEmail({required String code});

  Future<User> loginUser(UserLogInRequest request);

  Future<User> verifyLogin({required String code});

  Future<User> loginWithGoogle();

  Future<bool?> sendResetPasswordEmail({required String email});

  Future<void> sendEmailVerificationCode({required String email});

  Future<void> resendEmailVerificationCode();

  Future<User> confirmPassword(String password);
}
