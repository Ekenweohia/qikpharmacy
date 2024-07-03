import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/product/presentation/products_from_wholesaler_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/primary_button.dart';

class SuccessfullyUpdatedProductScreen extends StatelessWidget {
  final String message;
  final bool isEdit;

  const SuccessfullyUpdatedProductScreen({
    Key? key,
    required this.message,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icons/product_check_mark.png',
              scale: 3.5,
            ),
            const SizedBox(height: 23),
            Text(
              !isEdit
                  ? 'Product added Successfully'
                  : 'Product edited Successfully',
              style: textStyle15w500,
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: Text(
                message,
                style: textStyle13Light,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 31),
            PrimaryButton(
              title: 'Done',
              width: 124,
              onPressed: () {
                Navigator.pop(context);

                Navigator.maybePop(context);
              },
            ),
            const SizedBox(height: 31),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

                Navigator.maybePop(context);

                if (!isEdit) {
                  QikPharmaNavigator.push(
                    context,
                    const ProductsFromWholesalerScreen(),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isEdit)
                    const Icon(
                      Icons.keyboard_return,
                      size: 24,
                      color: AppCustomColors.primaryColor,
                    ),
                  const SizedBox(width: 10),
                  Text(
                    !isEdit ? 'Add more' : 'Back to Products',
                    style: textStyle13Light,
                  ),
                  const SizedBox(width: 10),
                  if (!isEdit)
                    Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(.1),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 12,
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
