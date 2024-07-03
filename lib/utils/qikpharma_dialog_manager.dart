import 'package:flutter/material.dart';

import '../shared/widgets/success_dialog.dart';

class QikPharmaDialogManager {
  static void showSuccessDialog(context, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          message: message,
        );
      },
    );
  }

  static void showLogoutDialog(context, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertLogoutDialog(
          message: message,
        );
      },
    );
  }

  static void showCloseAccountDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertCloseAccountDialog();
      },
    );
  }

  static void showDeleteDialog(context, shippingAddressId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDeleteDialog(shippingAddressId: shippingAddressId);
      },
    );
  }
}
