import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIconData;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color? iconColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? label;
  final bool obscureText;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    Key? key,
    required this.controller,
    this.hint,
    this.prefixIconData,
    this.iconColor,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.label,
    this.obscureText = false,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.text.isNotEmpty && label != null)
          Text(
            label!,
            style: textStyle12.copyWith(
              color: AppCustomColors.textBlue.withOpacity(.45),
            ),
          ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(
            children: [
              if (prefixIconData != null)
                Icon(
                  prefixIconData,
                  color: iconColor ?? Colors.grey,
                ),
              if (prefixIconData != null) const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  validator: validator,
                  enableSuggestions: true,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: textStyle15w400.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                  ),
                  cursorColor: AppCustomColors.primaryColor,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon,
                    contentPadding: const EdgeInsets.only(
                      bottom: 11,
                      top: 11,
                    ),
                    hintText: hint,
                    hintStyle: textStyle15w400.copyWith(
                      color: AppCustomColors.textBlue.withOpacity(.45),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
