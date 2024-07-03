import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/product_text_field.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/widgets/steps_progress_component.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_pin_entry_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

enum StepTwoStatus { pending, verfied, sent, done }

class VerifyNewEmailScreen extends StatefulWidget {
  final String email;
  const VerifyNewEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyNewEmailScreen> createState() => _VerifyNewEmailScreenState();
}

class _VerifyNewEmailScreenState extends State<VerifyNewEmailScreen> {
  final TextEditingController pinController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

  StepTwoStatus status = StepTwoStatus.pending;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(38, 20, 38, 0),
          child: SingleChildScrollView(
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
                      status == StepTwoStatus.done
                          ? 'Verification Completed'
                          : 'Identity verification',
                      style: textStyle24Bold,
                    ),
                    const Spacer(),
                    if (status != StepTwoStatus.done)
                      const Icon(
                        Icons.info_outlined,
                        color: AppCustomColors.darkRed,
                      )
                  ],
                ),
                const SizedBox(height: 41),
                StepsProgressComponent(
                  currentStep: status == StepTwoStatus.done ? 3 : 2,
                  completedSteps: status == StepTwoStatus.verfied
                      ? 2
                      : status == StepTwoStatus.done
                          ? 3
                          : 1,
                ),
                const SizedBox(height: 47),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserNewEmailVerified) {
                      setState(() {
                        status = StepTwoStatus.verfied;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularLoadingWidget(),
                      );
                    }

                    if (status == StepTwoStatus.pending) {
                      return pendingStatus();
                    }
                    if (status == StepTwoStatus.sent) {
                      return sentStatus();
                    }
                    if (status == StepTwoStatus.verfied) {
                      return verifiedStatus();
                    }
                    if (status == StepTwoStatus.done) {
                      return doneStatus();
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 29),
                if (status != StepTwoStatus.done &&
                    status != StepTwoStatus.verfied)
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
                          "Quick Tip",
                          style: textStyle15w500,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "1. Make sure the new email address is spelled correctly, so verification can be done",
                          style: textStyle15w400.copyWith(
                            color: Colors.black.withOpacity(.41),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          "2. Please check if your spam/inbox is full",
                          style: textStyle15w400.copyWith(
                            color: Colors.black.withOpacity(.41),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          "3. Check with your email operator to see if verification code email has been blocked",
                          style: textStyle15w400.copyWith(
                            color: Colors.black.withOpacity(.41),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (status == StepTwoStatus.done)
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.keyboard_return,
                          size: 24,
                          color: AppCustomColors.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Return to Account Settings',
                          style: textStyle13Light,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingStatus() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, color: Color.fromRGBO(39, 118, 237, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Enter a new email address to complete process',
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
                      "Current Address",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: 195,
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          widget.email,
                          style: textStyle13Light,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "New Email",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: 195,
                        height: 42,
                        child: ProductTextField(
                          placeholder: 'New email address',
                          errText: '',
                          controller: newEmailController,
                          onChanged: (String? value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "Verify New Email",
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
                if (newEmailController.text.isNotEmpty)
                  InkWell(
                    onTap: () async {
                      final cubit = BlocProvider.of<UserCubit>(context);

                      await cubit.sendEmailVerificationCodeToNewEmail(
                          email: newEmailController.text);

                      setState(() {
                        status = StepTwoStatus.sent;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget verifiedStatus() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, color: Color.fromRGBO(39, 118, 237, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Confirm your new email address',
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
                      "Current Address",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: 195,
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          widget.email,
                          style: textStyle13Light,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "New Email",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: 195,
                        height: 42,
                        child: ProductTextField(
                          placeholder: 'New email address',
                          errText: '',
                          controller: newEmailController,
                          onChanged: (String? value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Image.asset(
                            "assets/images/verification_code_sent_success_icon.png"),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Verified',
                            style: textStyle15w400.copyWith(
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      height: 37,
                      child: PrimaryButton(
                        title: 'Confirm',
                        width: 119,
                        onPressed: () async {
                          setState(() {
                            status = StepTwoStatus.done;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sentStatus() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, color: Color.fromRGBO(39, 118, 237, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Enter a new email address to complete process',
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
                      "Current Address",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: 195,
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          widget.email,
                          style: textStyle13Light,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "New Email",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: 195,
                        height: 42,
                        child: ProductTextField(
                          placeholder: 'New email address',
                          errText: '',
                          controller: newEmailController,
                          onChanged: (String? value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      "Verify New Email",
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
                              final cubit = BlocProvider.of<UserCubit>(context);

                              await cubit.verifyNewEmailCode(
                                email: newEmailController.text,
                                code: pinController.text,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () async {
                            final cubit = BlocProvider.of<UserCubit>(context);

                            await cubit.sendEmailVerificationCodeToNewEmail(
                              email: newEmailController.text,
                            );
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget doneStatus() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info, color: Color.fromRGBO(39, 118, 237, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Congratulations, email has been changed successfully',
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
                      "Current Address",
                      style: textStyle15w500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: 195,
                        height: 42,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          newEmailController.text,
                          style: textStyle13Light,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 19),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Image.asset(
                            "assets/images/verification_code_sent_success_icon.png"),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Verified',
                            style: textStyle15w400.copyWith(
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      height: 37,
                      child: PrimaryButton(
                        title: 'Done',
                        width: 119,
                        onPressed: () async {
                          Navigator.maybePop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
