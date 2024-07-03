import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CustomHeaderWithText extends StatelessWidget {
  const CustomHeaderWithText({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppCustomColors.textBlue,
          ),
        ),
        const SizedBox(width: 34),
        if (title != null)
          Text(
            title!,
            style: textStyle24Bold.copyWith(
              color: AppCustomColors.textBlue,
            ),
          ),
      ],
    );
  }
}
