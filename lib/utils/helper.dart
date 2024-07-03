// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/retailer_dashboard.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/user/user_dashboard.dart';
import 'package:qik_pharma_mobile/providers.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

class Helper {
  static String orderDetailHeaderText(String status) {
    switch (status) {
      case 'completed':
        return 'Delivered Order';
      case 'processed':
        return 'Order Processed';
      case 'created':
        return 'Order Processing';
      default:
        return 'Awaiting Payments';
    }
  }

  static String orderDetailSubText(String status) {
    switch (status) {
      case 'completed':
        return 'Delivered on';
      case 'processed':
        return 'Processed on';
      default:
        return 'Ordered on';
    }
  }

  static String formatAmountString(String amount) {
    return NumberFormat.decimalPattern().format(int.parse(amount));
  }

  static String getWalletType(String type) {
    switch (type) {
      case 'debit':
        return 'Account Withdrawal';
      default:
        return 'Account Funding';
    }
  }

  static String formatDate(String date) =>
      DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd").parse(date));

  static String formatTime(String date) => DateFormat("HH:mm a")
      .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").parse(date));

  static Future<bool> isUser() async {
    final String? role = await roleRepo.getUserRole();
    if (role != null && role.toLowerCase() == 'user') {
      return true;
    }

    return false;
  }

  static Future<void> getDashboard(BuildContext context,
      {int index = 0}) async {
    final res = await isUser();
    if (res) {
      QikPharmaNavigator.pushReplacement(
        context,
        UserDashboard(
          index: index,
        ),
      );
      return;
    }

    QikPharmaNavigator.pushReplacement(
      context,
      RetailerDashboard(
        index: index,
      ),
    );
  }

  static Future<String> currency() async => await OfflineClient().currency;

  static Uint8List convertToimage(String imageString) {
    // Decode the base64 string into bytes
    List<int> imageBytes = base64.decode(imageString.split(',').last);

    return Uint8List.fromList(imageBytes);
  }
}
