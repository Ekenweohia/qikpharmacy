import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class EmailNotificationScreen extends StatefulWidget {
  const EmailNotificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailNotificationScreen> createState() =>
      _EmailNotificationScreenState();
}

class _EmailNotificationScreenState extends State<EmailNotificationScreen> {
  bool isActive = false;

  User user = const User();
  bool loading = false;

  void switchToggle(bool value) {
    setState(() {
      isActive = !isActive;
    });

    final cubit = BlocProvider.of<UserCubit>(context);

    cubit.toggleEmailNotifications(isActive: isActive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF2F2F2),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                loading = true;
              });
            });
          }

          if (state is UserLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                loading = false;
                user = state.user;

                isActive = user.isEmailNotificationActive!;
              });
            });
          }
          return Column(
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
                      'Email notification',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification options ",
                            style: textStyle17w400,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: const Icon(
                              Icons.notifications_none,
                              color: AppCustomColors.primaryColor,
                              size: 15,
                            ),
                          ),
                        ],
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
                            'Email Notification',
                            style: textStyle15w400,
                          ),
                          loading
                              ? const Center(
                                  child: CircularLoadingWidget(),
                                )
                              : Switch(
                                  value:
                                      user.isEmailNotificationActive ?? false,
                                  onChanged: switchToggle,
                                  activeColor: AppCustomColors.primaryColor,
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
                          Icon(
                            Icons.check_circle,
                            color: user.isEmailNotificationActive ?? false
                                ? Colors.green
                                : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.isEmailNotificationActive ?? false
                                      ? "Enabled"
                                      : 'Disabled',
                                  style: textStyle15w400,
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  'Email verification allows you to receive notification alerts on your app',
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
              )
            ],
          );
        },
      ),
    );
  }
}
