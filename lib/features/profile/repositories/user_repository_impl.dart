import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';
import 'package:qik_pharma_mobile/core/models/response/single_country.dart';
import 'package:qik_pharma_mobile/core/models/response/toggle_fa.dart';
import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/login_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/onboarding.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/retailer_account_info_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/verify_email_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/welcome.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/retailer_dashboard.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/user_dashboard.dart';
import 'package:qik_pharma_mobile/features/profile/repositories/user_repository.dart';
import 'package:qik_pharma_mobile/features/splash/country_selection_screen.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class UserRepositoryImpl with UiLoggy implements UserRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  UserRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<void> setInit() async => await offlineClient.setBool(kInit, true);

  @override
  Future<Widget> authStatus() async {
    // Check if the user has completed the onboarding process
    final init = await offlineClient.getBool(kInit);
    if (init == null) {
      return const OnboardingScreen();
    }

    // Check if the base URL is set, if not, go to country selection
    final baseUrl = await offlineClient.getString(kBaseUrl);
    if (baseUrl == null) {
      final countries = await getListOfCountries();
      if (countries.isNotEmpty) {
        return CountrySelectionScreen(countries: countries);
      } else {
        return const SplashScreen();
      }
    }

    // Check if user data is available, if not, show the welcome screen
    final dataString = await offlineClient.getString(kUserData);
    if (dataString == null) {
      return const WelcomeScreen();
    }

    // Get user details from the database
    final user = await getUserDetailsFromDatabase();

    // Check if user has authenticated with 2FA
    final hasAuthenticatedWith2Fa =
        await offlineClient.getBool(kHasAuthenticated);

    if ((user.isTwoFA && (hasAuthenticatedWith2Fa ?? false)) || !user.isTwoFA) {
      // Check if user's email is verified
      if (user.isConfirmed == false) {
        return const VerifyEmailScreen();
      } else if (await Helper.isUser()) {
        return const UserDashboard();
      } else {
        // Check if user completed the retailer account creation screen
        final retailerDetails = await offlineClient.getString(kRetailerDetails);
        if (retailerDetails != null) {
          return const RetailerDashboard();
        }
        return const RetailerAccountInfoScreen();
      }
    } else {
      return const LoginScreen();
    }
  }

  @override
  Future<User> getUserDetailsFromDatabase() async {
    try {
      final response = await dioClient.get(
        'user/${await offlineClient.userId}',
      );

      User user = await baseUserResponse(response);

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<User> getUserDetails() async {
    final dataString = await offlineClient.getString(kUserData);
    if (dataString != null) {
      final user = User.fromJson(jsonDecode(dataString));
      return user;
    }

    return const User();
  }

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
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dioClient.post(
        'password/change/${await offlineClient.userId}',
        body: {
          "oldPassword": oldPassword,
          "password": newPassword,
        },
      );

      if (response == null || response.runtimeType == int) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User> updateUserDetails(UserSignUpRequest request) async {
    try {
      final response = await dioClient.put(
        'user/${await offlineClient.userId}',
        body: request.toJson(),
      );

// to save user details on retailer account creation screen for later checks,

      await offlineClient.setString(
          kRetailerDetails, jsonEncode(request.toJson()));

      User user = await baseUserResponse(response);

      return user;
    } catch (e) {
      return const User();
    }
  }

  @override
  Future<void> sendEmailVerificationCodeToNewEmail(
      {required String email}) async {
    try {
      final response = await dioClient.post(
        'new-email-verification/send',
        body: {
          'userId': await offlineClient.userId,
          'email': email,
        },
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
  Future<void> verifyNewEmailCode(
      {required String email, required String code}) async {
    try {
      final response = await dioClient.post(
        'new-email-verification/verify',
        body: {
          'email': email,
          'code': code,
        },
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      final res = await dioClient.put(
          'user/email/${await offlineClient.userId}',
          body: {"email": email});

      await baseUserResponse(res);

      return;
    } catch (e) {
      return;
    }
  }

  @override
  Future<User?> updateUserImage({required XFile? image}) async {
    try {
      String fileName = image!.path.split('/').last;

      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      final response = await dioClient.put(
        'user/picture/${await offlineClient.userId}',
        body: formData,
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      if (response['success']) {
        final res = await dioClient.get(
          'user/${await offlineClient.userId}',
        );

        final user = await baseUserResponse(res);

        if (user.userId != null) {
          return user;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      await offlineClient.clearData(kUserData);
      await offlineClient.clearData(kWalletLoggedIn);
      await offlineClient.clearData(kUserEmail);
      await offlineClient.clearData(kUserId);
      await offlineClient.clearData(kBaseUrl);
      await offlineClient.clearData(kHasAuthenticated);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      final response = await dioClient.delete(
        'user/${await offlineClient.userId}',
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      await offlineClient.clearData(kUserData);
      await offlineClient.clearData(kWalletLoggedIn);
      await offlineClient.clearData(kUserEmail);
      await offlineClient.clearData(kUserId);
      await offlineClient.clearData(kBaseUrl);

      return;
    } catch (e) {
      return;
    }
  }

  @override
  Future<bool> toggleEmailNotifications({required bool isActive}) async {
    try {
      final response = await dioClient.put(
        'user/notifications/${await offlineClient.userId}',
        body: {"enableNotifications": isActive},
      );

      if (response == null || response.runtimeType == int) {
        return false;
      }

      final user = await getUserDetailsFromDatabase();
      if (user.userId != null) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<SingleCountry>> getListOfCountries() async {
    List<SingleCountry> countries = [];

    try {
      final response =
          await dioClient.get('${Constants.baseUrl}countries-apis');

      if (response == null || response.runtimeType == int) {
        return countries;
      }

      response['data'].forEach((jsonModel) {
        countries.add(SingleCountry.fromJson(jsonModel));
      });

      return countries;
    } catch (e) {
      return countries;
    }
  }

  @override
  Future<bool?> setBaseParameters(SingleCountry selected) async {
    try {
      await offlineClient.setString(
          kBaseUrl, selected.apiLink ?? Constants.baseUrl);
      await offlineClient.setString(
          kCurrency, selected.countryCurrency ?? "GH₵");
      await offlineClient.setString(kPaystackPublicKey,
          selected.primaryKey ?? Constants.paystackPublicKey);

      return true;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ToggleFA> setupTwoFa(String password) async {
    try {
      final response = await dioClient
          .put('user/twofa/${await offlineClient.userId}', body: {
        'password': password,
      });

      if (response == null || response.runtimeType == int) {
        return ToggleFA();
      }

      final data = ToggleFA.fromJson(response['data']);

      await getUserDetailsFromDatabase();

      return data;
    } catch (e) {
      return ToggleFA();
    }
  }

  @override
  Future<bool> confirmTwoFa(String code) async {
    try {
      final response = await dioClient
          .put('user/confirm/twofa/${await offlineClient.userId}', body: {
        'code': code,
      });

      if (response == null || response.runtimeType == int) {
        return false;
      }

      final data = response['data']['isTwoFA'];

      if (data == true) {
        await offlineClient.setBool(kHasAuthenticated, true);
      }

      await getUserDetailsFromDatabase();

      return data;
    } catch (e) {
      return false;
    }
  }
}
