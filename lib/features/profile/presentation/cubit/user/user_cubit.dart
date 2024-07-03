import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/user_sign_up_request.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryImpl _userRepository;
  final AuthRepositoryImpl _authRepository;

  UserCubit(this._userRepository, this._authRepository)
      : super(const UserInitial());

  Future<void> updateUserDetails({
    String? companyName,
    String? address,
    String? country,
    String? state,
    String? phoneNumber,
    String? name,
    String? registrationNumber,
    String? companyType,
    String? businessType,
    String? medicatonType,
    String? zipCode,
    String? gender,
  }) async {
    emit(const UserLoading());

    UserSignUpRequest request = UserSignUpRequest(
      address: address,
      companyName: companyName,
      companyNumber: registrationNumber,
      country: country,
      name: name,
      phoneNumber: phoneNumber,
      state: state,
      zipCode: zipCode,
      gender: gender,
    );

    User user = await _userRepository.updateUserDetails(request);

    if (user.userId != null) {
      emit(UserDetailsUpdated(user));
      Future.delayed(const Duration(seconds: 1), () {
        getUserDetails();
      });
      return;
    }

    emit(const UserError());
    Future.delayed(const Duration(seconds: 1), () {
      getUserDetails();
    });
  }

  Future<void> getUserDetails() async {
    emit(const UserLoading());

    final user = await _userRepository.getUserDetails();

    if (user.userId != null) {
      emit(UserLoaded(user));

      return;
    }

    emit(const UserError());
  }

  Future<void> updateUserImage({required XFile? image}) async {
    emit(const UserLoading());

    final user = await _userRepository.updateUserImage(image: image);

    if (user != null) {
      emit(UserLoaded(user));

      return;
    }

    getUserDetails();
  }

  Future<void> sendEmailVerificationCode({required String email}) async {
    emit(const UserLoading());

    await _authRepository.sendEmailVerificationCode(email: email);

    getUserDetails();
  }

  Future<void> verifyEmailCode({required String code}) async {
    emit(const UserLoading());

    final user = await _authRepository.verifyEmail(code: code);

    if (user.userId != null) {
      emit(UserEmailVerified(user));

      Future.delayed(const Duration(seconds: 1), () {
        getUserDetails();
      });
      return;
    }

    emit(const UserError());
  }

  Future<void> resendEmailVerificationCode() async {
    emit(const UserLoading());

    await _authRepository.resendEmailVerificationCode();

    getUserDetails();
  }

  Future<void> sendEmailVerificationCodeToNewEmail(
      {required String email}) async {
    emit(const UserLoading());

    await _userRepository.sendEmailVerificationCodeToNewEmail(email: email);

    getUserDetails();
  }

  Future<void> verifyNewEmailCode(
      {required String email, required String code}) async {
    emit(const UserLoading());

    await _userRepository.verifyNewEmailCode(email: email, code: code);

    emit(const UserNewEmailVerified());

    Future.delayed(const Duration(seconds: 1), () {
      getUserDetails();
    });
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const UserLoading());

    final result = await _userRepository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    if (result) {
      emit(const UserPasswordChanged());

      Future.delayed(const Duration(seconds: 1), () {
        getUserDetails();
      });
      return;
    }

    emit(const UserError());
  }

  Future<void> logOut() async {
    emit(const UserLoading());

    final result = await _userRepository.logOut();
    if (result) {
      emit(const UserLoggedOut());
      return;
    }

    emit(const UserError());
  }

  Future<void> deleteUser() async {
    emit(const UserLoading());

    await _userRepository.deleteUser();
  }

  Future<void> toggleEmailNotifications({required bool isActive}) async {
    emit(const UserLoading());

    final result =
        await _userRepository.toggleEmailNotifications(isActive: isActive);

    if (result) {
      emit(const UserNewEmailNotificationsStatusUpdated());

      Future.delayed(const Duration(seconds: 1), () {
        getUserDetails();
      });
      return;
    }

    emit(const UserError());
  }
}
