import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PasswordChangedSuccessfullyScreen extends StatelessWidget {
  const PasswordChangedSuccessfullyScreen({Key? key}) : super(key: key);

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
                "Password Successfully Changed",
                style: textStyle17Bold.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 31),
              SizedBox(
                width: 200,
                child: Image.asset(
                  "assets/images/change_password_success_icon.png",
                ),
              ),
              const SizedBox(height: 67),
              Text(
                "Your account password has been changed successfully. You can login with your new password to continue.",
                style: textStyle16White,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                title: 'Ok',
                textColor: Colors.black,
                buttonColor: Colors.white,
                width: 180,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
