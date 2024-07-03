import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/cubit/two_fa_cubit.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/widgets/two_fa_confirmed_dialog.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';

class TwoFactorAuthenticationScreen extends StatefulWidget {
  const TwoFactorAuthenticationScreen({
    Key? key,
    required this.password,
    this.fromLogin = false,
  }) : super(key: key);

  final String password;
  final bool fromLogin;

  @override
  State<TwoFactorAuthenticationScreen> createState() =>
      _TwoFactorAuthenticationScreenState();
}

class _TwoFactorAuthenticationScreenState
    extends State<TwoFactorAuthenticationScreen> {
  final _codeController = TextEditingController();

  bool buttonEnabled = false;
  bool revealSecret = false;

  @override
  void initState() {
    super.initState();

    if (!widget.fromLogin) {
      _getTwoFaData();
    }
  }

  void _getTwoFaData() {
    final cubit = BlocProvider.of<SetupTwoFaCubit>(context);
    cubit.call(password: widget.password);
  }

  void _confirmTwoFaCode() {
    final cubit = BlocProvider.of<ConfirmTwoFaCubit>(context);
    cubit.call(code: _codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 32,
                      color: AppCustomColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Two-Factor Authentication',
                    style: textStyle19w400.copyWith(
                        color: AppCustomColors.textBlue),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (!widget.fromLogin)
                BlocConsumer<SetupTwoFaCubit, SetUpTwoFaState>(
                  listener: (context, state) async {
                    if (state is TwoFaDisabled) {
                      final userCubit = BlocProvider.of<UserCubit>(context);
                      userCubit.getUserDetails();

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is SetUpTwoFaLoading) {
                      return const Center(
                        child: CircularLoadingWidget(),
                      );
                    }

                    if (state is SetupTwoFa) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Setup two-factor authentication',
                              style: textStyle15w400.copyWith(
                                color: AppCustomColors.textBlue,
                              ),
                            ),
                            const SizedBox(height: 31),
                            Text(
                              'To be able to authenticate transactions you need to scan this QR code with your Google Authentication app and enter the active verification code below ',
                              style: textStyle15w400.copyWith(
                                color: AppCustomColors.textBlue,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppCustomColors.pinBorderinactiveColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: revealSecret ||
                                      (state.result.qrcode ?? '').isEmpty
                                  ? GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: state.result.secret ?? '',
                                          ),
                                        );

                                        showToast('Copied to clipboard!');
                                      },
                                      child: Text(
                                        state.result.secret ?? '',
                                        style: textStyle15w400.copyWith(
                                          color: AppCustomColors.textBlue,
                                        ),
                                      ),
                                    )
                                  : state.result.qrcode != null
                                      ? Image.memory(
                                          Helper.convertToimage(
                                            state.result.qrcode!,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ),
                            if ((state.result.qrcode ?? '').isNotEmpty)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () => setState(() {
                                    revealSecret = !revealSecret;
                                  }),
                                  child: Text(
                                    !revealSecret
                                        ? 'Use one-time password instead'
                                        : 'Use QR code instead',
                                    style: textStyle12.copyWith(
                                      color: AppCustomColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 23),
                            buildVerificationCodeSection(),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              if (widget.fromLogin) const SizedBox(height: 23),
              if (widget.fromLogin) buildVerificationCodeSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerificationCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification Code',
          style: textStyle15w400.copyWith(
            color: AppCustomColors.textBlue,
          ),
        ),
        const SizedBox(height: 19),
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
          controller: _codeController,
          autoDisposeControllers: false,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            inactiveColor: Colors.grey[300],
            activeColor: AppCustomColors.primaryColor,
            selectedColor: Colors.grey[300],
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                buttonEnabled = true;
              });
            });
          },
          onChanged: (String value) {
            // if (value.isNotEmpty && value.length < 6) {
            //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //     setState(() {
            //       buttonEnabled = false;
            //     });
            //   });
            // }
          },
        ),
        const SizedBox(height: 29),
        BlocConsumer<ConfirmTwoFaCubit, ConfirmTwoFaState>(
          listener: (context, state) {
            if (state is TwoFaEnabled) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return TwoFaConfirmedDialog(
                    fromLogin: widget.fromLogin,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              title: 'Confirm',
              isEnabled: buttonEnabled,
              onPressed: buttonEnabled ? () => _confirmTwoFaCode() : null,
              loading: state is ConfirmTwoFaLoading,
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
