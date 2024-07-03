import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/account_wallet_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletVerifiedScreen extends StatelessWidget {
  const WalletVerifiedScreen({Key? key}) : super(key: key);

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
            children: [
              const Spacer(),
              Text(
                'Wallet Verified',
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
                // color: Colors.black,
                child: Image.asset(
                  "assets/images/verified.png",
                  height: 229,
                  width: 229,
                  fit: BoxFit.contain,
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
                'Great job, your wallet pin has been successfully created and verified, you can continue to enter pin',
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
                    context, const AccountWalletScreen()),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
