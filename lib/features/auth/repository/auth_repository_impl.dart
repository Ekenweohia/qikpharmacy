import 'package:qik_pharma_mobile/features/auth/repository/auth_repository.dart';

import 'dart:convert';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/models/request/google_sign_up_req.dart';
import 'package:qik_pharma_mobile/core/models/request/user_log_in_request.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';
import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';

class AuthRepositoryImpl with UiLoggy implements AuthRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  AuthRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  Future<User> baseUserResponse(dynamic response) async {
    if (response == null || response.runtimeType == int) {
      return const User();
    }

    User user = User.fromJson(response["data"]);

    await offlineClient.setString(kUserData, jsonEncode(user.toJson()));
    await offlineClient.setString(kUserId, user.userId ?? '');
    await offlineClient.setString(kUserEmail, user.email ?? '');

    return user;
  }

  @override
  Future<User> registerUser(UserSignUpRequest request) async {
    logDebug(request.toJson());

    try {
      final response = await dioClient.post(
        'signup',
        body: request.toJson(),
      );

      User user = await baseUserResponse(response);

      if (user.userId != null) {
        await sendEmailVerificationCode(email: request.email!);
      }

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<User> loginUser(UserLogInRequest request) async {
    try {
      final response = await dioClient.post(
        'app/login',
        body: request.toJson(),
      );

      User user = await baseUserResponse(response);

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<User> verifyEmail({required String code}) async {
    try {
      final response = await dioClient.post(
        'verify-email/${await offlineClient.userId}',
        body: {'code': code},
      );

      User user = await baseUserResponse(response);

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<User> verifyLogin({required String code}) async {
    try {
      final response = await dioClient.post(
        'login/verify/${await offlineClient.userId}',
        body: {'code': code},
      );

      User user = await baseUserResponse(response);

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<void> sendEmailVerificationCode({required String email}) async {
    try {
      final response = await dioClient.post(
        'send-email-code',
        body: {'email': email},
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      showToast(response['message']);
      return;
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> resendEmailVerificationCode() async {
    try {
      final response = await dioClient.post(
        'resend-email-code',
        body: {'userId': await offlineClient.userId},
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      showToast(response['data']);
      return;
    } catch (e) {
      return;
    }
  }

  @override
  Future<bool?> sendResetPasswordEmail({required String email}) async {
    try {
      final response = await dioClient.post(
        'password/send',
        body: {'email': email},
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }
      logDebug(response);
      final status = response['success'];

      showToast(response['data']);
      return status;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        showToast('Something went wrong!');
        return const User();
      }

      final request = GoogleSignUpRequest(
        name: (await googleUser.authentication).accessToken,
        email: googleUser.email,
        imagePath: googleUser.photoUrl,
      );

      final response = await dioClient.post(
        'google/login',
        body: request.toJson(),
      );

      if (response == null || response.runtimeType == int) {
        return const User();
      }

      var decodedData = json.decode(response)['data'];

      User user = User.fromJson(decodedData);

      await offlineClient.setString(kUserData, jsonEncode(user.toJson()));

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<User> confirmPassword(String password) async {
    try {
      final dataString = await offlineClient.getString(kUserData);
      if (dataString != null) {
        final user = User.fromJson(jsonDecode(dataString));

        final request = UserLogInRequest(
          email: user.email,
          password: password,
        );
        final response = await dioClient.post(
          'app/login',
          body: request.toJson(),
        );

        return await baseUserResponse(response);
      }

      return const User();
    } catch (e) {
      return const User();
    }
  }
}
