import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/registration/sign_up_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/role/role_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/login_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/verify_email_screen.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/widgets/account_type_overlay.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_header_with_text.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _referralCodeController = TextEditingController();

  Role selectedRole = Role();
  bool _obscureText = true;

  @override
  void initState() {
    _getRoles();
    super.initState();
  }

  void _getRoles() async {
    final roleCubit = BlocProvider.of<RoleCubit>(context);
    roleCubit.getRoles();
  }

  void _registerUser() async {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    await cubit.registerUser(
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
      roleId: selectedRole.roleId!,
      referralCode: _referralCodeController.text,
    );
  }

  bool buttonEnabled() =>
      _emailController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      selectedRole.roleId != null &&
      _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccessful) {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 1000),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: const VerifyEmailScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(32, 27, 32, 0),
              child: Column(
                children: [
                  const CustomHeaderWithText(title: 'Create your account'),
                  const SizedBox(height: 75),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose account type',
                              style: textStyle12.copyWith(
                                color:
                                    AppCustomColors.textBlue.withOpacity(.45),
                              ),
                            ),
                            const SizedBox(height: 4),
                            BlocBuilder<RoleCubit, RoleState>(
                              builder: (context, state) {
                                if (state is RoleLoaded) {
                                  return AccountTypeOverlay(
                                    roles: state.roles
                                        .where((e) =>
                                            e.name?.toLowerCase() == 'user' ||
                                            e.name?.toLowerCase() == 'retailer')
                                        .toList(),
                                    selectedRole: (value) {
                                      setState(() {
                                        selectedRole = value;
                                      });
                                    },
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            InputField(
                              hint: 'Your Name',
                              label: 'Your Name',
                              validator: (val) {
                                if (!val!.isValidName) {
                                  return 'Missing a First or Last name';
                                }
                                return null;
                              },
                              controller: _nameController,
                              onChanged: (final value) {
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 58),
                            InputField(
                              hint: 'Email',
                              label: 'Email',
                              validator: (val) {
                                if (!val!.isValidEmail) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              onChanged: (final value) {
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 58),
                            InputField(
                              hint: 'Password',
                              label: 'Password',
                              validator: (val) {
                                if (!val!.isValidPassword) {
                                  return 'Password must be more than 6 characters \nwhich contain at least one numeric digit,\none uppercase and one lowercase letter';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              onChanged: (final value) {
                                setState(() {});
                              },
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
                              obscureText: _obscureText,
                            ),
                            const SizedBox(height: 58),
                            InputField(
                              hint: 'Referral Code (Optional)',
                              label: 'Referral Code',
                              validator: (val) {
                                return null;
                              },
                              controller: _referralCodeController,
                              onChanged: (final value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  PrimaryButton(
                    title: 'CREATE ACCOUNT',
                    isEnabled: buttonEnabled(),
                    onPressed: buttonEnabled() ? () => _registerUser() : null,
                    loading: state is SignUpLoading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account?",
                        style: textStyle14w400.copyWith(
                          color: AppCustomColors.textBlue.withOpacity(.45),
                        ),
                      ),
                      TextButton(
                        onPressed: () => QikPharmaNavigator.pushReplacement(
                          context,
                          const LoginScreen(),
                        ),
                        child: Text(
                          "Login",
                          style: textStyle14w400.copyWith(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
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
