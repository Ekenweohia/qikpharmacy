import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';
import 'package:qik_pharma_mobile/core/repositories/paystack_repository.dart';
import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';
import 'package:qik_pharma_mobile/features/wallet/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;
  final UserRepositoryImpl userRepositoryImpl;
  final PayStackRepository payStackRepository;

  WalletRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
    required this.userRepositoryImpl,
    required this.payStackRepository,
  });

  @override
  Future<void> changeWalletPin({
    required String oldPin,
    required String newPin,
  }) async {
    try {
      final response = await dioClient.put(
        'wallet/update-pin/${await offlineClient.userId}',
        body: {"oldPin": oldPin, "pin": newPin},
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      showToast(response['data']);
    } catch (e) {
      return;
    }
  }

  @override
  Future<bool?> createWalletPin(String pin) async {
    try {
      final response = await dioClient.post(
        'wallet/set-pin/${await offlineClient.userId}',
        body: {"pin": pin},
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      showToast(response['data']);
      return await sendEmailVerificationCode();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> creditWallet(BuildContext context, double amount) async {
    try {
      final response = await payStackRepository.cardPayment(context, amount);

      if (response == 'Success') {
        final user = await userRepositoryImpl.getUserDetails();

        final response = await dioClient.post(
          'wallet/credit/${user.wallet!.walletId}',
          body: {
            "amount": amount,
            "description": "credit",
          },
        );

        if (response == null || response.runtimeType == int) {
          return null;
        }

        return true;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> debitWallet(CheckoutPayload payload) async {
    try {
      final user = await userRepositoryImpl.getUserDetails();

      final response = await dioClient.post(
        'wallet/debit/${user.wallet!.walletId}',
        body: {
          "amount": payload.amount,
          "description": "withdrawal",
        },
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      final res = await dioClient.post(
        'order/${await offlineClient.userId}',
        body: {
          "cartItemIds": payload.cartItemIds,
          "shippingCompanyId": payload.shippingCompanyId,
        },
      );

      if (res == null || res.runtimeType == int) {
        return null;
      }

      return true;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Wallet> getWalletDetails() async {
    try {
      final response =
          await dioClient.get('wallet/${await offlineClient.userId}');

      if (response == null || response.runtimeType == int) {
        return Wallet();
      }

      final wallet = Wallet.fromJson(response['data']);

      wallet.isLoggednIn = (await offlineClient.isWalletLoggedIn);
      return wallet;
    } catch (e) {
      return Wallet();
    }
  }

  Future<bool?> sendEmailVerificationCode() async {
    try {
      final response = await dioClient.post(
        'wallet/send-email/${await offlineClient.userId}',
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      return true;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> verifyCode(String code) async {
    try {
      final response = await dioClient.post(
        'wallet/confirm-email-pin/${await offlineClient.userId}',
        body: {"code": code},
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      return true;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Wallet> verifyWalletPin(String pin) async {
    try {
      final response = await dioClient.post(
        'wallet/login/${await offlineClient.userId}',
        body: {"pin": pin},
      );

      if (response == null || response.runtimeType == int) {
        showToast('Wallet pin provided is incorrect!');

        return Wallet();
      }

      final wallet = Wallet.fromJson(response['data']);

      if (wallet.walletId != null) {
        await offlineClient.setBool(kWalletLoggedIn, true);
        return wallet;
      }

      return Wallet();
    } catch (e) {
      return Wallet();
    }
  }
}
