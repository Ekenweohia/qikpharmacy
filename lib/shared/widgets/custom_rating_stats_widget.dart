import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/product.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_progress_indicator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CustomRatingStatsWidget extends StatelessWidget {
  final List<ProductReviews> productReviews;

  const CustomRatingStatsWidget({
    Key? key,
    required this.productReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getPercentage(int index) {
      final average = productReviews.where((e) => e.rating == index).length;
      final total = productReviews.length;
      final percentage = (average / total) * 100;

      return percentage;
    }

    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: _item(
              index: index + 1,
              percentage: getPercentage(index + 1).toInt(),
              progress: getPercentage(index + 1) / 100),
        ),
      ),
    );
  }

  Widget _item({
    required int index,
    required double progress,
    required num percentage,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$index', style: textStyle11Light),
        const SizedBox(width: 5),
        Icon(Icons.star, size: 14, color: Colors.amber[700]),
        const SizedBox(width: 10),
        CustomProgressIndicator(progress: progress),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          child: Text(
            '$percentage%',
            style: textStyle11Light,
          ),
        ),
      ],
    );
  }
}
