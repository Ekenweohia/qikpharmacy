import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/response/cart.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';
import 'package:qik_pharma_mobile/features/cart/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  CartRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<Cart> getCart() async {
    try {
      final response =
          await dioClient.get('cart/${await offlineClient.userId}');

      if (response == null || response.runtimeType == int) {
        return Cart();
      }

      final cart = Cart.fromJson(response['data']);

      return cart;
    } catch (e) {
      return Cart();
    }
  }

  @override
  Future<bool?> addToCart({required String productId}) async {
    try {
      final response = await dioClient.post(
        'cart/add/${await offlineClient.userId}',
        body: {
          'productId': productId,
          'quantity': 1,
        },
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
  Future<bool?> updateToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await dioClient.post(
        'cart/update/${await offlineClient.userId}',
        body: {
          'productId': productId,
          'quantity': quantity,
        },
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
  Future<bool?> deleteFromCart({required String productId}) async {
    try {
      final response = await dioClient.post(
        'cart/${await offlineClient.userId}',
        body: {'productId': productId},
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Logistics>> getLogistics() async {
    List<Logistics> logistics = [];

    try {
      final response = await dioClient.get('logistics');

      if (response == null || response.runtimeType == int) {
        return logistics;
      }

      response['data'].forEach((d) {
        logistics.add(Logistics.fromJson(d));
      });

      return logistics;
    } catch (e) {
      debugPrint(e.toString());
      return logistics;
    }
  }
}
