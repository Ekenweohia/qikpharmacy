import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/password_confirmation_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/change_password/change_password_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PasswordAndSecurityScreen extends StatefulWidget {
  const PasswordAndSecurityScreen({Key? key}) : super(key: key);

  @override
  State<PasswordAndSecurityScreen> createState() =>
      _PasswordAndSecurityScreenState();
}

class _PasswordAndSecurityScreenState extends State<PasswordAndSecurityScreen> {
  void _getUserDetails() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getUserDetails();
  }

  @override
  void initState() {
    super.initState();

    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF2F2F2),
      body: Column(
        children: [
          Container(
            height: 120,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(38, 60, 38, 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppCustomColors.textBlue,
                  ),
                ),
                const SizedBox(width: 21),
                Text(
                  'Password & Security',
                  style: textStyle24Bold,
                )
              ],
            ),
          ),
          const SizedBox(height: 9),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 15, 38, 0),
                  child: Text(
                    "Authentication Options",
                    style: textStyle17w400,
                  ),
                ),
                Divider(color: Colors.black.withOpacity(.2)),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: textStyle15w400,
                      ),
                      InkWell(
                        onTap: () {
                          QikPharmaNavigator.push(
                            context,
                            const ChangePasswordScreen(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(.5),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password has been set",
                              style: textStyle15w400,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "Choose a strong, unique password that's at least 8 characters long.",
                              style: textStyle15w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 15, 38, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Two-step verification options',
                                    style: textStyle17w400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Add an extra layer of security to block unauthorized access and protect your account.',
                                    style: textStyle14w400,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                QikPharmaNavigator.push(
                                  context,
                                  const PasswordConfirmationScreen(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(.5),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.settings,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black.withOpacity(.2)),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Authenticator app code',
                                      style: textStyle15w400,
                                    ),
                                    const SizedBox(width: 32),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: AppCustomColors.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(.5),
                                          ),
                                        ),
                                        child: Text(
                                          '?',
                                          style: textStyle12.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '(Recommended)',
                                  style: textStyle15w400,
                                ),
                              ],
                            ),
                            Container(
                              width: 48,
                              height: 26,
                              decoration: BoxDecoration(
                                color: state.user.isTwoFA
                                    ? AppCustomColors.primaryColor
                                    : AppCustomColors.textBlue.withOpacity(.3),
                                borderRadius: BorderRadius.circular(36),
                              ),
                              padding: const EdgeInsets.all(1.5),
                              alignment: state.user.isTwoFA
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  QikPharmaNavigator.push(
                                    context,
                                    const PasswordConfirmationScreen(),
                                  );
                                },
                                child: Container(
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.check_circle,
                                color: state.user.isTwoFA
                                    ? AppCustomColors.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.isTwoFA ? 'Enabled' : 'Disabled',
                                    style: textStyle15w400,
                                  ),
                                  if (!state.user.isTwoFA)
                                    const SizedBox(height: 7),
                                  if (!state.user.isTwoFA)
                                    Text(
                                      'Enter a code generated by your authenticator app to confirm its you.',
                                      style: textStyle15w400,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
