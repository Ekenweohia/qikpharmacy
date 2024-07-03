import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/retailer_account_info_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  bool isUser = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      Future.delayed(Duration.zero, () async {
        isUser = await Helper.isUser();
      });
    });
  }

  _gotoProperRouteBasedOnUserRole() async {
    if (isUser) {
      await Helper.getDashboard(context);
    } else {
      QikPharmaNavigator.pushReplacement(
        context,
        const RetailerAccountInfoScreen(),
      );
    }
  }

  String _getEmailVerifiedMessage(String userRole) {
    String message = isUser
        ? "Congratulations, your email  has\n been verified. You can start using\n the app."
        : "Congratulations, your email  has been\n verified. You can click continue to\n complete your account information.";
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("assets/images/success.png"),
              const SizedBox(height: 83),
              Text(
                "Email Verified",
                style: textStyle24Bold,
              ),
              const SizedBox(height: 16),
              Text(
                _getEmailVerifiedMessage(''),
                style: textStyle16Light.copyWith(
                  color: AppCustomColors.textBlue.withOpacity(.45),
                  height: 1.3,
                  letterSpacing: .5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                title: 'Continue'.toUpperCase(),
                onPressed: () async => await _gotoProperRouteBasedOnUserRole(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
