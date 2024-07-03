import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/models/response/single_country.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final UserRepositoryImpl _userRepositoryImpl;

  SplashCubit(this._userRepositoryImpl) : super(const SplashInitial());

  void authStatus() async {
    emit(const SplashLoading());

    final result = await _userRepositoryImpl.authStatus();
    emit(SplashLoaded(route: result));
    return;
  }

  void setBaseParameters(SingleCountry country) async {
    emit(const SplashLoading());

    final result = await _userRepositoryImpl.setBaseParameters(country);

    if (result != null) {
      authStatus();
    }

    emit(const SplashError());
  }
}
