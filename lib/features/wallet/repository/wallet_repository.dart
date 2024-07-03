import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';

abstract class WalletRepository {
  Future<bool?> createWalletPin(String pin);
  Future<bool?> verifyCode(String code);
  Future<Wallet> verifyWalletPin(String pin);
  Future<Wallet> getWalletDetails();
  Future<bool?> creditWallet(BuildContext context, double amount);
  Future<void> debitWallet(CheckoutPayload payload);
  Future<void> changeWalletPin({
    required String oldPin,
    required String newPin,
  });
}
