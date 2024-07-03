// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_naza/flutter_paystack_naza.dart';
import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

class PayStackRepository {
  final PaystackPlugin _paystackPlugin = PaystackPlugin();

  Future<String> cardPayment(BuildContext context, num amount) async {
    final reference = _getReference();
    await _paystackPlugin.initialize(
        publicKey: await OfflineClient().paystackKey);

    Charge charge = Charge()
      ..amount = (amount * 100).toInt()
      ..email = '${await OfflineClient().getString(kUserEmail)}'
      ..reference = reference
      ..currency = await OfflineClient().currency == "₦" ? 'NGN' : 'GHS';

    try {
      CheckoutMethod method = CheckoutMethod.card;

      CheckoutResponse response = await _paystackPlugin.checkout(
        context,
        method: method,
        charge: charge,
        fullscreen: false,
        logo: _logo(),
        hideEmail: true,
      );

      String apiResponse = response.message;

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget _logo() {
    return SizedBox(
      height: 60,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
