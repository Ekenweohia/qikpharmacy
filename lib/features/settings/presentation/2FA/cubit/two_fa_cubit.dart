import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/models/response/toggle_fa.dart';

part 'two_fa_state.dart';

class SetupTwoFaCubit extends Cubit<SetUpTwoFaState> {
  final UserRepositoryImpl _userRepository;

  SetupTwoFaCubit(this._userRepository) : super(const SetUpTwoFaInitial());

  Future<void> call({required String password}) async {
    emit(const SetUpTwoFaLoading());

    final result = await _userRepository.setupTwoFa(password);

    if (result.isTwoFa == false) {
      emit(const TwoFaDisabled());

      return;
    }

    emit(SetupTwoFa(result));

    return;
  }
}

class ConfirmTwoFaCubit extends Cubit<ConfirmTwoFaState> {
  final UserRepositoryImpl _userRepository;

  ConfirmTwoFaCubit(this._userRepository) : super(const ConfirmTwoFaInitial());

  Future<void> call({required String code}) async {
    emit(const ConfirmTwoFaLoading());

    final result = await _userRepository.confirmTwoFa(code);

    if (result) {
      emit(const TwoFaEnabled());
    }

    emit(const ConfirmTwoFaError());
  }
}
