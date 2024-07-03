import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final int length;
  final String hint;
  final bool showPrefix;
  final bool readOnly;

  const WalletTextfield({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.length = 4,
    required this.hint,
    this.showPrefix = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195,
      height: 42,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppCustomColors.primaryColor),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(length),
        ],
        cursorColor: AppCustomColors.primaryColor,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: showPrefix
              ? const Icon(
                  Icons.lock_outline_rounded,
                  color: AppCustomColors.primaryColor,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
