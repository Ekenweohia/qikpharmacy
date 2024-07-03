import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/change_email/change_email_account_with_new_email_screen.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/steps_progress_component.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_pin_entry_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

enum StepOneStatus { pending, progress, sent, done }

class ChangeAccountEmailScreen extends StatefulWidget {
  const ChangeAccountEmailScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAccountEmailScreen> createState() =>
      _ChangeAccountEmailScreenState();
}

class _ChangeAccountEmailScreenState extends State<ChangeAccountEmailScreen> {
  StepOneStatus status = StepOneStatus.pending;
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(38, 20, 38, 0),
          child: Column(
            children: [
              Row(
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
                    'Identity verification',
                    style: textStyle24Bold,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.info_outlined,
                    color: AppCustomColors.darkRed,
                  )
                ],
              ),
              const SizedBox(height: 41),
              const StepsProgressComponent(
                currentStep: 1,
                completedSteps: 0,
              ),
              const SizedBox(height: 47),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserEmailVerified) {
                    QikPharmaNavigator.pushReplacement(
                      context,
                      VerifyNewEmailScreen(email: state.user.email!),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return Column(
                      children: [
                        if (status == StepOneStatus.pending)
                          pendingStatus(state.user.email!)
                        else if (status == StepOneStatus.progress ||
                            status == StepOneStatus.sent)
                          progressStatus(state.user.email!)
                      ],
                    );
                  }

                  if (state is UserLoading) {
                    return const Center(
                      child: CircularLoadingWidget(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingStatus(String email) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: textStyle15w500Black,
            children: [
              const TextSpan(text: "Verification in process "),
              TextSpan(
                text: email,
                style: textStyle15w500Black.copyWith(
                  color: AppCustomColors.red,
                ),
              ),
              const TextSpan(
                text: " select the method of verification.",
              ),
            ],
          ),
        ),
        const SizedBox(height: 31),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppCustomColors.nonActiveProgressColor, width: 1.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 21,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "By Email Verification",
                      style: textStyle15w500Black,
                    ),
                    SizedBox(
                      height: 37,
                      child: PrimaryButton(
                        title: 'Verify now',
                        width: 119,
                        onPressed: () {
                          setState(() {
                            status = StepOneStatus.progress;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "If your email is still in use, please choose this way to verify your identity",
                  style: textStyle15w400,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget progressStatus(String email) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, color: Color.fromRGBO(39, 118, 237, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "If you would like to verify your account by email verification, please follow these steps",
                style: textStyle15w300,
              ),
            )
          ],
        ),
        const SizedBox(height: 19),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppCustomColors.nonActiveProgressColor,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Email Address",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 195,
                      height: 42,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppCustomColors.primaryColor),
                      ),
                      child: Text(
                        email,
                        style: textStyle13Light,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "Verification Code",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    WalletPinEntryWidget(
                      controller: pinController,
                      length: 6,
                      width: 150,
                      onChanged: (String value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                if (status == StepOneStatus.progress)
                  InkWell(
                    onTap: () async {
                      final cubit = BlocProvider.of<UserCubit>(context);

                      await cubit.sendEmailVerificationCode(email: email);

                      setState(() {
                        status = StepOneStatus.sent;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: Container()),
                        Image.asset("assets/images/click_icon.png"),
                        Text(
                          "Click here to receive\n a verification code ",
                          style: textStyle15w400.copyWith(
                            color: AppCustomColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (status == StepOneStatus.sent)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                              "assets/images/verification_code_sent_success_icon.png"),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "A verification code has been sent to your email address , and it will be valid for 15 min. Please also check your junk mail and enter the valid code",
                              style: textStyle15w400.copyWith(
                                color: Colors.black.withOpacity(.41),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            height: 37,
                            child: PrimaryButton(
                              title: 'Submit',
                              width: 119,
                              onPressed: () async {
                                final cubit =
                                    BlocProvider.of<UserCubit>(context);

                                await cubit.verifyEmailCode(
                                    code: pinController.text);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          TextButton(
                            onPressed: () async {
                              final cubit = BlocProvider.of<UserCubit>(context);

                              await cubit.resendEmailVerificationCode();
                            },
                            child: Text(
                              "Resend",
                              style: textStyle15w400.copyWith(
                                color: AppCustomColors.red,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
        const SizedBox(height: 29),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(199, 195, 166, 0.1),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Didn't receive email verification code?",
                style: textStyle15w500,
              ),
              const SizedBox(height: 10),
              Text(
                "1. Your email code may take up to 10 minutes to arrive depending on your email service provider, Please do not repeat clicking ",
                style: textStyle15w400.copyWith(
                  color: Colors.black.withOpacity(.41),
                ),
              ),
              const SizedBox(height: 13),
              Text(
                "2. Please check if your trash/spam folder or mail inbox is full ",
                style: textStyle15w400.copyWith(
                  color: Colors.black.withOpacity(.41),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
