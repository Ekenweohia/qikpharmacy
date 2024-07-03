import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccountUnderReviewScreen extends StatefulWidget {
  const AccountUnderReviewScreen({Key? key}) : super(key: key);

  @override
  State<AccountUnderReviewScreen> createState() =>
      _AccountUnderReviewScreenState();
}

class _AccountUnderReviewScreenState extends State<AccountUnderReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  "assets/images/account_under_review_icon.png",
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "Account Under Review",
                style: textStyle17w500Black.copyWith(
                    color: AppCustomColors.textBlue),
              ),
              const SizedBox(height: 17),
              Text(
                "Sorry your account is currently under\n review by admin, your account will be\n enabled for use once verified by admin",
                style: textStyle14w400.copyWith(
                  color: AppCustomColors.textBlue.withOpacity(.45),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 95),
              PrimaryButton(
                title: 'CONTINUE',
                onPressed: () => QikPharmaNavigator.pushReplacement(
                  context,
                  const SplashScreen(),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                child: Text(
                  "Contact support",
                  style: textStyle13w400PrimaryUnderlined,
                ),
                onPressed: () => _gotoContactPage(),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoContactPage() async {
    String url = Constants.contactSupportPageUrl;
    await launchUrlString(url);
  }
}
