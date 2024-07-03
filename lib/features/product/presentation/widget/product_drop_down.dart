import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductDropDown extends StatelessWidget {
  final dynamic initialValue;
  final Function(dynamic) onChanged;
  final List<DropdownMenuItem> dropdownMenuItem;

  const ProductDropDown({
    Key? key,
    required this.dropdownMenuItem,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      style: textStyle13Light,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 26),
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
        filled: true,
        fillColor: Colors.white,
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppCustomColors.primaryColor,
      ),
      value: initialValue,
      onChanged: onChanged,
      items: dropdownMenuItem,
    );
  }
}
