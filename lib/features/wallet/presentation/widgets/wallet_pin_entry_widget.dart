import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletPinEntryWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final int length;
  final double width;

  const WalletPinEntryWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.length = 4,
    this.width = 195,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 42,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.fromLTRB(25, 11, 25, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppCustomColors.primaryColor),
      ),
      child: SizedBox(
        width: 100,
        child: PinCodeTextField(
          appContext: context,
          length: length,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          autoDisposeControllers: false,
          obscureText: false,
          animationType: AnimationType.fade,
          autoFocus: true,
          cursorColor: AppCustomColors.primaryColor,
          controller: controller,
          textStyle: textStyle11Light.copyWith(fontWeight: FontWeight.w600),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            inactiveColor: Colors.grey[300],
            activeColor: AppCustomColors.primaryColor,
            selectedColor: Colors.grey[300],
            fieldHeight: 20,
            fieldWidth: 10,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
