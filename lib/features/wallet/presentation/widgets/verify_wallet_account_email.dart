import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/wallet_verified_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class VerifyWalletAccountEmail extends StatefulWidget {
  const VerifyWalletAccountEmail({Key? key}) : super(key: key);

  @override
  State<VerifyWalletAccountEmail> createState() =>
      _VerifyWalletAccountEmailState();
}

class _VerifyWalletAccountEmailState extends State<VerifyWalletAccountEmail> {
  final _pinController = TextEditingController();

  bool buttonEnabled() => _pinController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Container(
        height: 350,
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 21),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletEmailVerified) {
              Navigator.pop(context);
              QikPharmaNavigator.pushReplacement(
                  context, const WalletVerifiedScreen());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Image.asset(
                  'assets/images/ic_verify.png',
                  height: 63,
                  width: 63,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 195,
                  height: 52,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppCustomColors.primaryColor),
                  ),
                  child: InputField(
                    hint: 'Enter code',
                    validator: null,
                    controller: _pinController,
                    onChanged: (final value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'To verify this process, kindly enter the 6 digit code sent to your account email',
                  textAlign: TextAlign.center,
                  style: textStyle13w400,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  title: 'Verify',
                  width: 126,
                  onPressed: () {
                    final cubit = BlocProvider.of<WalletCubit>(context);
                    cubit.verifyCode(_pinController.text);
                  },
                  isEnabled: buttonEnabled(),
                  loading: state is WalletLoading,
                ),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Didnt recieve code?', style: textStyle11Light),
                    const SizedBox(width: 3),
                    GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                        // final cubit = BlocProvider.of<WalletCubit>(context);
                        // cubit.sendEmailVerificationCode();
                      },
                      child: Text(
                        'Resend',
                        style: textStyle11Light.copyWith(
                          color: AppCustomColors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
