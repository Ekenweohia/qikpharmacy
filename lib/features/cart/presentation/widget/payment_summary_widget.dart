import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final num subTotal;
  final num discount;
  final double total;
  final ValueNotifier<Logistics?> selectedLogistics;
  final String? currency;

  const PaymentSummaryWidget({
    Key? key,
    required this.discount,
    required this.subTotal,
    required this.total,
    required this.selectedLogistics,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'Payment Summary',
            style: textStyle16Bold.copyWith(
              color: AppCustomColors.textBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Total',
              style: textStyle14w400.copyWith(
                color: AppCustomColors.textBlue.withOpacity(.45),
              ),
            ),
            Text(
              '$currency ${subTotal.toStringAsFixed(2)}',
              style: textStyle14w400,
            ),
          ],
        ),
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
                child: Text(
              'Items Discount',
              style: textStyle14w400.copyWith(
                color: AppCustomColors.textBlue.withOpacity(.45),
              ),
            )),
            FittedBox(
              child: Text(
                '-$currency $discount',
                style: textStyle14w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                'Shipping',
                style: textStyle14w400.copyWith(
                  color: AppCustomColors.textBlue.withOpacity(.45),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                '$currency ${selectedLogistics.value?.pricePerKm ?? 0}',
                style: textStyle14w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: textStyle16Bold.copyWith(
                color: AppCustomColors.textBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$currency ${(total + (selectedLogistics.value?.pricePerKm ?? 0)).toStringAsFixed(2)}',
              style: textStyle16Bold.copyWith(
                color: AppCustomColors.textBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
