import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Center(
                child: Image.asset("assets/images/ic_emptycart.png"),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Whoops',
            style: textStyle16Light.copyWith(
              fontWeight: FontWeight.w400,
              color: AppCustomColors.textBlue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Your cart is empty!',
            style: textStyle14w400.copyWith(
              color: AppCustomColors.textBlue.withOpacity(.45),
            ),
          )
        ],
      ),
    );
  }
}
