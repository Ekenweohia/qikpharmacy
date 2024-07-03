import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/reset_password_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/sign_up_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/two_factor_authentication_screen.dart';
import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool _obscureText = true;

  bool buttonEnabled() =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _formKey.currentState!.validate();

  void _login() async {
    final cubit = BlocProvider.of<LoginCubit>(context);
    await cubit.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginVerified) {
              if (state.user.isTwoFA == false) {
                QikPharmaNavigator.pushReplacement(
                  context,
                  const SplashScreen(),
                );

                return;
              }

              QikPharmaNavigator.pushReplacement(
                context,
                TwoFactorAuthenticationScreen(
                  password: _passwordController.text,
                  fromLogin: true,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    padding: const EdgeInsets.only(top: 5),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: AppCustomColors.textBlue,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ic_login_logo.png",
                              height: 93,
                              width: 109,
                            ),
                            const SizedBox(height: 99),
                            Center(
                              child: Text(
                                "Welcome Back!",
                                style: textStyle24Bold.copyWith(
                                  color: AppCustomColors.textBlue,
                                ),
                              ),
                            ),
                            const SizedBox(height: 54),
                            InputField(
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color.fromARGB(255, 2, 24, 42),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.text,
                              hint: 'Email',
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
                            const SizedBox(height: 33),
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
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () => QikPharmaNavigator.push(
                                    context,
                                    ResetPasswordScreen(
                                        email: _emailController.text)),
                                child: Text(
                                  'Forgot?',
                                  style:
                                      textStyle12.copyWith(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    title: 'LOGIN',
                    isEnabled: buttonEnabled(),
                    onPressed: buttonEnabled() ? () => _login() : null,
                    loading: state is LoginLoading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: textStyle14w400.copyWith(
                          color: AppCustomColors.textBlue.withOpacity(.45),
                        ),
                      ),
                      TextButton(
                        onPressed: () => QikPharmaNavigator.pushReplacement(
                          context,
                          const SignUpScreen(),
                        ),
                        child: Text(
                          'Sign Up',
                          style: textStyle14w400.copyWith(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
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
