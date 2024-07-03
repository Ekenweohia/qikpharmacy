import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/add_shipping_address_screen.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/shipping_address_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ShippingUpdateSuccessful extends StatelessWidget {
  final String title;
  final String content;

  const ShippingUpdateSuccessful({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54),
              child: Column(
                children: [
                  Text(
                    title,
                    style: textStyle24Bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 31),
                  Container(
                    height: 229,
                    width: 229,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/rocket.png',
                        height: 93,
                        width: 93,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: Text(
                      'Great work',
                      style: textStyle20.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: textStyle17w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTap: () => QikPharmaNavigator.pushReplacement(
                      context,
                      const AddNewShippingAddressScreen(),
                    ),
                    child: Container(
                      height: 45,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 7,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),
                  PrimaryButton(
                    title: 'Continue',
                    textColor: Colors.black,
                    buttonColor: Colors.white,
                    width: 180,
                    onPressed: () => QikPharmaNavigator.pushReplacement(
                      context,
                      const ShippingAddressScreen(),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
