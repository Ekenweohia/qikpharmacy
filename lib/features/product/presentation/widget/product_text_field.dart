import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductTextField extends StatelessWidget {
  final String placeholder;
  final String errText;
  final TextEditingController controller;
  final int maxLines;
  final Color textColor;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;

  const ProductTextField({
    Key? key,
    required this.controller,
    required this.errText,
    required this.placeholder,
    this.maxLines = 1,
    this.textColor = AppCustomColors.textBlue,
    this.inputFormatters,
    this.onChanged,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ??
          (_) {
            return null;
          },
      enableSuggestions: true,
      // keyboardType: keyboardType,
      style: textStyle13Light.copyWith(color: textColor),
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      cursorColor: AppCustomColors.primaryColor,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: AppCustomColors.primaryColor.withOpacity(.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: AppCustomColors.primaryColor.withOpacity(.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: AppCustomColors.primaryColor.withOpacity(.4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: AppCustomColors.primaryColor.withOpacity(.4)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        hintText: placeholder,
        hintStyle: textStyle13Light.copyWith(
          color: const Color(0XFF090F47),
        ),
      ),
    );
  }
}
