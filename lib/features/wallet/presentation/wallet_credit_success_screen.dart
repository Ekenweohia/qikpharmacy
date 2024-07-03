import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/wallet_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletCreditSuccessScreen extends StatelessWidget {
  const WalletCreditSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 41,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wallet Credited',
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
                    'assets/images/credited.png',
                    height: 229,
                    width: 229,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: Text(
                  'Congratuations !!',
                  style: textStyle20.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Congratulations your wallet funding was successful, and your account has been updated ',
                textAlign: TextAlign.center,
                style: textStyle17w400.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 56),
              PrimaryButton(
                title: 'Continue',
                textColor: Colors.black,
                buttonColor: Colors.white,
                width: 180,
                onPressed: () => QikPharmaNavigator.pushReplacement(
                    context, const WalletScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
