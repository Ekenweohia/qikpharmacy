import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';
import 'package:qik_pharma_mobile/features/wallet/repository/wallet_repository_impl.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepositoryImpl _walletRepositoryImpl;

  WalletCubit(this._walletRepositoryImpl) : super(const WalletInitial());

  void getWalletDetails() async {
    emit(const WalletLoading());

    final result = await _walletRepositoryImpl.getWalletDetails();

    if (result.isLoggednIn != null && result.isLoggednIn!) {
      emit(WalletLoggedIn(result));
      return;
    }

    emit(WalletLoaded(result));
  }

  void createWalletPin(String pin) async {
    emit(const WalletLoading());

    final result = await _walletRepositoryImpl.createWalletPin(pin);

    if (result != null && result) {
      emit(const WalletCreated());
      return;
    }

    emit(const WalletError());
  }

  void verifyCode(String pin) async {
    emit(const WalletLoading());

    final result = await _walletRepositoryImpl.verifyCode(pin);

    if (result != null && result) {
      emit(const WalletEmailVerified());
      return;
    }

    emit(const WalletError());
  }

  void verifyWalletPin(String pin) async {
    emit(const WalletLoading());

    final result = await _walletRepositoryImpl.verifyWalletPin(pin);

    if (result.walletId != null) {
      emit(WalletLoggedIn(result));
      return;
    }

    emit(const WalletLoginError());
  }

  void creditWallet(BuildContext context, double amount) async {
    final result = await _walletRepositoryImpl.creditWallet(context, amount);

    if (result != null && result) {
      emit(const WalletCredited());
      getWalletDetails();
      return;
    }
  }

  void debitWallet(BuildContext context, CheckoutPayload payload) async {
    emit(const WalletLoading());

    final result = await _walletRepositoryImpl.debitWallet(payload);

    if (result != null && result) {
      emit(const WalletDebited());
    }

    emit(const WalletError());
  }

  void sendEmailVerificationCode() async =>
      await _walletRepositoryImpl.sendEmailVerificationCode();
}
