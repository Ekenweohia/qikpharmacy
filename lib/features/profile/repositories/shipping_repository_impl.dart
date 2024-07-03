import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/response/shipping_address.dart';
import 'package:qik_pharma_mobile/core/models/request/add_address.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

abstract class ShippingRepository {
  Future<List<ShippingAddress>> getShippingAddress();
  Future<bool?> addShippingAddress(AddAddressRequest req);
  Future<bool?> updateShippingAddress({
    required AddAddressRequest req,
    required String shippingAddressId,
  });

  Future<void> deleteShippingAddress({
    required String shippingAddressId,
  });
}

class ShippingRepositoryImpl implements ShippingRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  ShippingRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<ShippingAddress>> getShippingAddress() async {
    List<ShippingAddress> shippingAddressList = [];

    try {
      final response = await dioClient.get(
        'user/shippingaddresses/${await offlineClient.userId}',
      );

      if (response == null || response.runtimeType == int) {
        return <ShippingAddress>[];
      }

      final addressList = response['data'];

      addressList.forEach((jsonModel) {
        shippingAddressList.add(ShippingAddress.fromJson(jsonModel));
      });

      return shippingAddressList;
    } catch (e) {
      return <ShippingAddress>[];
    }
  }

  @override
  Future<bool?> addShippingAddress(AddAddressRequest req) async {
    try {
      final response = await dioClient.post(
        'user/shippingaddress/${await offlineClient.userId}',
        body: req.toJson(),
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      final address = ShippingAddress.fromJson(response['data']);

      if (address.shippingAddressId != null) {
        return true;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> updateShippingAddress({
    required AddAddressRequest req,
    required String shippingAddressId,
  }) async {
    try {
      final response = await dioClient.put(
        'user/shippingaddress/$shippingAddressId',
        body: req.toJson(),
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }

      final address = ShippingAddress.fromJson(response['data']);

      if (address.shippingAddressId != null) {
        return true;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteShippingAddress({
    required String shippingAddressId,
  }) async {
    try {
      final response = await dioClient.delete(
        'user/shippingaddress/$shippingAddressId',
      );

      if (response == null || response.runtimeType == int) {
        return;
      }

      showToast(response['data']);
      return;
    } catch (e) {
      return;
    }
  }
}
