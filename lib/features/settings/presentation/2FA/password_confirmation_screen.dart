import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/two_factor_authentication_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PasswordConfirmationScreen extends StatefulWidget {
  const PasswordConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<PasswordConfirmationScreen> createState() =>
      _PasswordConfirmationScreenState();
}

class _PasswordConfirmationScreenState
    extends State<PasswordConfirmationScreen> {
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  bool buttonEnabled() => _passwordController.text.isNotEmpty;

  void _confirmPassword() async {
    final cubit = BlocProvider.of<LoginCubit>(context);
    await cubit.confirmPassword(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginVerified) {
              QikPharmaNavigator.pushReplacement(
                context,
                TwoFactorAuthenticationScreen(
                    password: _passwordController.text),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: 56),
                  Text(
                    'Please confirm your password before continuing.',
                    style: textStyle15w400,
                  ),
                  const SizedBox(height: 32),
                  InputField(
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 2, 24, 42),
                    ),
                    controller: _passwordController,
                    hint: 'Password',
                    validator: (value) {
                      if (value == null) {
                        return 'Field cannot be empty.';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: _obscureText
                          ? const Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                    ),
                    onChanged: (final value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 120),
                  PrimaryButton(
                    title: 'Continue',
                    isEnabled: buttonEnabled(),
                    onPressed:
                        buttonEnabled() ? () => _confirmPassword() : null,
                    loading: state is LoginLoading,
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
