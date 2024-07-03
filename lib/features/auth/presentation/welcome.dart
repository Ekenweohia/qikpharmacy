import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/login_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/sign_up_screen.dart';

import '../../../utils/utils.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _navigate(page) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 1000),
        type: PageTransitionType.rightToLeftWithFade,
        child: page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(),
              Image.asset("assets/images/welcome_image.png"),
              const SizedBox(height: 34),
              Text(
                "Welcome to qikPharma",
                style: textStyle24Bold.copyWith(
                  color: AppCustomColors.textBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Text(
                  "Do you want some help with your health to get better life?",
                  style: textStyle16Light.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              _buildSignUpButton(),
              const SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () => _navigate(const LoginScreen()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: textStyle16BoldAppColor.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.arrow_forward,
              color: AppCustomColors.primaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: AppCustomColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: () => _navigate(const SignUpScreen()),
        child: Text(
          'SIGN UP WITH EMAIL',
          style: textStyle16BoldWhite.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
