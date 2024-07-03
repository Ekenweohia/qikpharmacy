import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qik_pharma_mobile/core/models/response/product.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductReviewItem extends StatelessWidget {
  final ProductReviews productReview;
  const ProductReviewItem({Key? key, required this.productReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productReview.createdAt != null)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat('dd - MMM yyyy')
                    .format(DateTime.parse(productReview.createdAt!)),
                style: textStyle14w400.copyWith(
                  color: AppCustomColors.textBlue.withOpacity(.45),
                ),
              ),
            ),
          const SizedBox(height: 7),
          if (productReview.rating != null)
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber[700],
                  size: 12,
                ),
                const SizedBox(width: 3),
                Text(
                  '${productReview.rating}',
                  style: textStyle13w400.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                  ),
                )
              ],
            ),
          const SizedBox(height: 7),
          if (productReview.review != null)
            Text(
              '${productReview.review}',
              style: textStyle14w400.copyWith(
                color: AppCustomColors.textBlue.withOpacity(.45),
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
    );
  }
}
