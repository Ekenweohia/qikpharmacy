import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/product_text_field.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/change_password/password_change_successfully_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  bool buttonEnabled() =>
      _oldPasswordController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _newPasswordController.text == _confirmNewPasswordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(38, 20, 38, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Image.asset(
                        "assets/images/close_icon_primary_color.png"),
                  ),
                  const SizedBox(width: 21),
                  Text(
                    'Change Password',
                    style: textStyle24Bold,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Old Password',
                style: textStyle15w400,
              ),
              const SizedBox(height: 11),
              ProductTextField(
                placeholder: '',
                errText: '',
                controller: _oldPasswordController,
                onChanged: (String? value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'New password',
                    style: textStyle15w400,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: obscureText
                            ? AppCustomColors.primaryColor
                            : Colors.white,
                        border: Border.all(color: AppCustomColors.primaryColor),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Show password',
                    style: textStyle15w400,
                  ),
                ],
              ),
              const SizedBox(height: 11),
              ProductTextField(
                placeholder: '',
                errText: '',
                controller: _newPasswordController,
                obscureText: obscureText,
                onChanged: (String? value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 28),
              Text(
                'Confirm New Password',
                style: textStyle15w400,
              ),
              const SizedBox(height: 11),
              ProductTextField(
                placeholder: '',
                errText: '',
                controller: _confirmNewPasswordController,
                validator: (final value) {
                  if (_newPasswordController.text != value) {
                    return 'Passwords do not match!';
                  }

                  return null;
                },
                obscureText: obscureText,
                onChanged: (String? value) {
                  setState(() {});
                },
              ),
              const Spacer(),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserPasswordChanged) {
                    QikPharmaNavigator.pushReplacement(
                      context,
                      const PasswordChangedSuccessfullyScreen(),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: CircularLoadingWidget(),
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.maybePop(context),
                        child: Text(
                          "Cancel",
                          style: textStyle15w400.copyWith(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      PrimaryButton(
                        title: 'Save',
                        width: 119,
                        isEnabled: buttonEnabled(),
                        onPressed: buttonEnabled()
                            ? () async {
                                final cubit =
                                    BlocProvider.of<UserCubit>(context);

                                await cubit.changePassword(
                                  oldPassword: _oldPasswordController.text,
                                  newPassword: _newPasswordController.text,
                                );
                              }
                            : null,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
