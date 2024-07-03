import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/verify_wallet_account_email.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_pin_entry_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  final TextEditingController _pinController = TextEditingController();

  bool buttonEnabled() =>
      _pinController.text.isNotEmpty && _pinController.text.length == 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletCreated) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) =>
                    const VerifyWalletAccountEmail(),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        'Create Wallet',
                        style: textStyle20Bold.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 92),
                  Container(
                    height: 124,
                    width: 124,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(width: 10, color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/wallet.png",
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "Kindly input 4 digit pin",
                    style: textStyle20.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),
                  WalletPinEntryWidget(
                    controller: _pinController,
                    onChanged: (String value) {
                      if (value.isNotEmpty && value.length <= 4) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {});
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  PrimaryButton(
                    title: 'Create',
                    width: 126,
                    onPressed: buttonEnabled()
                        ? () {
                            final cubit = BlocProvider.of<WalletCubit>(context);
                            cubit.createWalletPin(_pinController.text);
                          }
                        : null,
                    isEnabled: buttonEnabled(),
                    loading: state is WalletLoading,
                  ),
                  const SizedBox(height: 28),
                  Image.asset(
                    "assets/images/ic_secure.png",
                    height: 31,
                    width: 81,
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
