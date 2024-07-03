import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';
import 'package:qik_pharma_mobile/core/models/response/single_country.dart';
import 'package:qik_pharma_mobile/core/models/response/toggle_fa.dart';

abstract class UserRepository {
  Future<Widget> authStatus();

  Future<User> getUserDetailsFromDatabase();

  Future<void> setInit();

  Future<User> getUserDetails();

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<User> updateUserDetails(UserSignUpRequest request);

  Future<void> sendEmailVerificationCodeToNewEmail({required String email});

  Future<void> verifyNewEmailCode(
      {required String email, required String code});

  Future<User?> updateUserImage({required XFile? image});

  Future<bool> logOut();

  Future<void> deleteUser();

  Future<bool> toggleEmailNotifications({required bool isActive});

  Future<List<SingleCountry>> getListOfCountries();

  Future<bool?> setBaseParameters(SingleCountry selected);

  Future<ToggleFA> setupTwoFa(String password);

  Future<bool> confirmTwoFa(String code);
}
