import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';

import '../../utils/utils.dart';
import 'primary_button.dart';

class DeleteProductAlertDialog extends StatelessWidget {
  final String productId;

  const DeleteProductAlertDialog({
    Key? key,
    required this.productId,
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
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icons/alert_icon.png',
              scale: 3.5,
            ),
            const SizedBox(height: 23),
            Text(
              'Do you wish to continue?',
              style: textStyle15w500.copyWith(
                color: const Color(0XFF090F47),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Click yes if you wish to continue to delete this product. Note products delected cannot be available anymore in your store',
              style: textStyle13Light,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  title: 'No',
                  width: 124,
                  hasBorder: true,
                  borderColor: const Color(0XFFAB2F2F),
                  textColor: const Color(0XFFAB2F2F),
                  onPressed: () => Navigator.pop(context),
                ),
                PrimaryButton(
                    title: 'Yes',
                    width: 124,
                    onPressed: () {
                      Navigator.pop(context);

                      BlocProvider.of<UserProductCubit>(context)
                          .deleteProduct(productId: productId);
                    }),
              ],
            ),
            const SizedBox(height: 31),
          ],
        ),
      ),
    );
  }
}

class DeleteSuccessfulDialog extends StatelessWidget {
  const DeleteSuccessfulDialog({
    Key? key,
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
              'assets/images/icons/product_deleted_icon.png',
              scale: 3.5,
            ),
            const SizedBox(height: 23),
            Text(
              'Deleted Successfully',
              style: textStyle15w500,
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: Text(
                'Selected products have been successfully deleted from your store',
                style: textStyle13Light,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 31),
            PrimaryButton(
              title: 'Done',
              width: 124,
              onPressed: () => Navigator.maybePop(context),
            ),
          ],
        ),
      ),
    );
  }
}
