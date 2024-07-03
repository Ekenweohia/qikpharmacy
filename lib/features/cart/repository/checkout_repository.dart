import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/repositories/paystack_repository.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

abstract class CheckoutRepository {
  Future<bool?> handleCheckout(BuildContext context, CheckoutPayload payload);
}

class CheckoutRepositoryImpl implements CheckoutRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;
  final PayStackRepository payStackRepository;

  CheckoutRepositoryImpl({
    required this.payStackRepository,
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<bool?> handleCheckout(
      BuildContext context, CheckoutPayload payload) async {
    try {
      final response =
          await payStackRepository.cardPayment(context, payload.amount!);

      if (response == 'Success') {
        final response = await dioClient.post(
          'order/${await offlineClient.userId}',
          body: {
            "cartItemIds": payload.cartItemIds,
            "shippingCompanyId": payload.shippingCompanyId,
          },
        );

        if (response == null || response.runtimeType == int) {
          return null;
        }

        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
