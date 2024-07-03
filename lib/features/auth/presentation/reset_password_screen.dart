import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/login_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.email);
  }

  bool buttonEnabled() =>
      _emailController.text.isNotEmpty && _emailController.text.isValidEmail;

  void _resetPassword() {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);
    cubit.sendResetPasswordEmail(email: _emailController.text);
  }

  void _navigateToLogin() =>
      QikPharmaNavigator.pushReplacement(context, const LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetEmailSent) {
              _navigateToLogin();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(32, 27, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: AppCustomColors.textBlue,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Forgot your password?',
                    style: textStyle24Bold,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please enter your email address below to receive your password reset instructions. ',
                    style: textStyle13Light.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppCustomColors.lightTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    hint: 'Email',
                    label: 'Email',
                    validator: (val) {
                      if (!val!.isValidEmail) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                    onChanged: (final value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    title: 'Send',
                    isEnabled: buttonEnabled(),
                    onPressed: buttonEnabled() ? () => _resetPassword() : null,
                    loading: state is ResetEmailLoading,
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: TextButton(
                      onPressed: () => _navigateToLogin(),
                      child: Text(
                        "Back to Sign in",
                        style: textStyle14w500PrimaryUnderlined,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
