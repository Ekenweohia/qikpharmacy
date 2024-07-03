import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PaymentMethodItem extends StatelessWidget {
  final String title;
  final String image;
  final String? walletBalance;
  final String? currency;

  const PaymentMethodItem({
    Key? key,
    required this.title,
    required this.image,
    this.walletBalance,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Image.asset(image),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle14Bold.copyWith(
                color: AppCustomColors.textBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (walletBalance != null) const SizedBox(height: 5),
            if (walletBalance != null)
              Text(
                '$currency ${walletBalance!}',
                style: textStyle11Light,
              ),
          ],
        ),
      ],
    );
  }
}
