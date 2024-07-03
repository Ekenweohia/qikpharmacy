import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qik_pharma_mobile/barrels/cubits.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/email_verified_screen.dart';
import 'package:qik_pharma_mobile/shared/extensions/string_extension.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _otpController = TextEditingController();
  Duration duration = const Duration();
  Timer? timer;
  int count = 60;
  bool buttonEnabled = false;

  @override
  Future<void> dispose() async {
    timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (count < 1) {
            timer.cancel();
          } else {
            count = count - 1;
          }
        },
      ),
    );
  }

  void _resendCode() async {
    setState(() {
      count = 60;

      startTimer();
    });
    final cubit = BlocProvider.of<OtpVerificationCubit>(context);
    cubit.resendEmailVerificationCode();
  }

  void _verifyCode() async {
    final cubit = BlocProvider.of<OtpVerificationCubit>(context);

    cubit.verifyEmail(code: _otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
          listener: (context, state) {
            if (state is OtpVerified) {
              QikPharmaNavigator.pushReplacement(
                context,
                const EmailVerifiedScreen(),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: AppCustomColors.textBlue,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Text(
                      "Enter the verification code",
                      style: textStyle24Bold.copyWith(
                          color: AppCustomColors.textBlue),
                    ),
                    const SizedBox(height: 17),
                    Text(
                      "We just send you a verification code to your email enter code to verify",
                      style: textStyle14w400.copyWith(
                          color: AppCustomColors.textBlue.withOpacity(.45)),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 25),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      obscureText: false,
                      animationType: AnimationType.fade,
                      autoFocus: true,
                      cursorColor: AppCustomColors.primaryColor,
                      controller: _otpController,
                      autoDisposeControllers: false,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        inactiveColor: Colors.grey[300],
                        activeColor: AppCustomColors.primaryColor,
                        selectedColor: Colors.grey[300],
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {
                            buttonEnabled = true;
                          });
                        });
                      },
                      onChanged: (String value) {
                        if (value.isNotEmpty && value.length < 6) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            setState(() {
                              buttonEnabled = false;
                            });
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 29),
                    PrimaryButton(
                      title: 'SUBMIT CODE',
                      isEnabled: buttonEnabled,
                      onPressed: buttonEnabled ? () => _verifyCode() : null,
                      loading: state is OtpVerificationLoading,
                    ),
                    const SizedBox(height: 23),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Haven't received code? Resend in 00:${count.toString().formatTime}",
                        style: textStyle16Light,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (count == 0 && state is! OtpVerificationLoading)
                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => _resendCode(),
                          child: Text(
                            "Resend code",
                            style: textStyle14w400.copyWith(
                                color: AppCustomColors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
