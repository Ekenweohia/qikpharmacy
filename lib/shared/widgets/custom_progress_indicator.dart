import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? progress;

  const CustomProgressIndicator({
    Key? key,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3.2;
    const radius = Radius.circular(10);

    return ClipRRect(
      borderRadius: const BorderRadius.all(radius),
      child: SizedBox(
        height: 4,
        width: width,
        child: Stack(
          children: [
            Container(
              color: Colors.grey.withOpacity(.3),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width * progress!,
                decoration: const BoxDecoration(
                  color: AppCustomColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
