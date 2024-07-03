import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/models/response/error_model.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import 'dio_logger.dart';

class DioClient with UiLoggy {
  final Dio _dio = Dio(
    BaseOptions(
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000)),
  )..interceptors.add(DioLogger());

  Future get(url, {Map<String, dynamic>? params}) async {
    try {
      final request = await _dio.get(
        '${await OfflineClient().baseUrl}$url',
        queryParameters: params ?? {},
        options: OfflineClient().accessToken == null
            ? null
            : Options(headers: {'apiKey': OfflineClient().accessToken}),
      );

      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        return e.response;
      }

      final error = ErrorModel.fromJson(e.response?.data);

      if (error.data != null) {
        showToast(error.data.runtimeType == List ? error.data[0] : error.data);
      }

      return e.response!.statusCode;
    }
  }

  Future post(url, {Map<String, dynamic>? params, dynamic body}) async {
    try {
      final request = await _dio.post(
        '${await OfflineClient().baseUrl}$url',
        data: body,
        queryParameters: params ?? {},
        options: OfflineClient().accessToken == null
            ? null
            : Options(headers: {'apiKey': OfflineClient().accessToken}),
      );

      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        return e.response;
      }

      loggy.debug(e.response);
      final error = ErrorModel.fromJson(e.response?.data);

      if (error.data != null) {
        showToast(error.data.runtimeType == List ? error.data[0] : error.data);
      }

      return e.response!.statusCode;
    }
  }

  Future put(url, {Map<String, dynamic>? params, dynamic body}) async {
    try {
      final request = await _dio.put(
        '${await OfflineClient().baseUrl}$url',
        data: body,
        queryParameters: params ?? {},
        options: OfflineClient().accessToken == null
            ? null
            : Options(headers: {'apiKey': OfflineClient().accessToken}),
      );

      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        return e.response;
      }

      loggy.debug(e.response);

      final error = ErrorModel.fromJson(e.response?.data);

      if (error.data != null) {
        showToast(error.data.runtimeType == List ? error.data[0] : error.data);
      }

      return e.response!.statusCode;
    }
  }

  Future delete(url, {Map<String, dynamic>? params, dynamic body}) async {
    try {
      final request = await _dio.delete(
        '${await OfflineClient().baseUrl}$url',
        data: body,
        queryParameters: params ?? {},
        options: OfflineClient().accessToken == null
            ? null
            : Options(headers: {'apiKey': OfflineClient().accessToken}),
      );

      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        return e.response;
      }

      final error = ErrorModel.fromJson(e.response?.data);

      if (error.data != null) {
        showToast(error.data.runtimeType == List ? error.data[0] : error.data);
      }

      return e.response!.statusCode;
    }
  }
}
