import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CheckoutCompletedScreen extends StatefulWidget {
  const CheckoutCompletedScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutCompletedScreen> createState() =>
      _CheckoutCompletedScreenState();
}

class _CheckoutCompletedScreenState extends State<CheckoutCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 54),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Hurray! Order Completed',
                style: textStyle24Bold.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 31),
              Image.asset('assets/images/order_completed.png'),
              const SizedBox(height: 35),
              Text(
                'Thank you',
                style: textStyle20.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Your Order will be delivered soon. You can track the delivery in the order section.',
                textAlign: TextAlign.center,
                style: textStyle17w400.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 56),
              PrimaryButton(
                title: 'Order More',
                textColor: Colors.black,
                buttonColor: Colors.white,
                width: 180,
                onPressed: () async => await Helper.getDashboard(context),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
