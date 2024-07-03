import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/create_wallet_screen.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/wallet_screen.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_text_field.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class AccountWalletScreen extends StatefulWidget {
  const AccountWalletScreen({Key? key}) : super(key: key);

  @override
  State<AccountWalletScreen> createState() => _AccountWalletScreenState();
}

class _AccountWalletScreenState extends State<AccountWalletScreen> {
  final TextEditingController _pinController = TextEditingController();
  Wallet wallet = Wallet();
  bool isLoading = true;

  @override
  void initState() {
    _getWalletDetails();
    super.initState();
  }

  void _getWalletDetails() {
    final cubit = BlocProvider.of<WalletCubit>(context);
    cubit.getWalletDetails();
  }

  bool buttonEnabled() =>
      _pinController.text.isNotEmpty && _pinController.text.length == 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletLoading) {
              setState(() {
                isLoading = true;
              });
            }

            if (state is WalletLoggedIn) {
              QikPharmaNavigator.pushReplacement(context, const WalletScreen());

              setState(() {
                isLoading = false;
              });
            }

            if (state is WalletLoaded) {
              setState(() {
                wallet = state.wallet;

                isLoading = false;
              });
            }

            if (state is WalletLoginError) {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: wallet.walletId == null
              ? const Center(child: CircularLoadingWidget())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 38, vertical: 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async => await Helper.getDashboard(
                              context,
                              index: 2,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            "My Account Wallet",
                            style: textStyle20Bold.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 38),
                      Container(
                        height: 192,
                        width: 192,
                        padding: const EdgeInsets.all(4),
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
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 55),
                      if (isLoading)
                        const Center(child: CircularLoadingWidget())
                      else if (!isLoading && !wallet.isActive!)
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.info,
                                    color: AppCustomColors.blue,
                                    size: 34,
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create a qikpharma wallet',
                                          style: textStyle20.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 13),
                                        Text(
                                          'Click the button below to create a quick wallet for your account, easy and secured.',
                                          textAlign: TextAlign.start,
                                          style: textStyle15w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 126,
                                child: PrimaryButton(
                                  title: 'Get Started',
                                  onPressed: () => QikPharmaNavigator.push(
                                    context,
                                    const CreateWalletScreen(),
                                  ),
                                ),
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
                        )
                      else
                        Expanded(
                          child: Column(
                            children: [
                              WalletTextfield(
                                controller: _pinController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                hint: 'Enter pin',
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 126,
                                child: PrimaryButton(
                                  title: 'Login',
                                  isEnabled: buttonEnabled(),
                                  onPressed: buttonEnabled()
                                      ? () {
                                          final cubit =
                                              BlocProvider.of<WalletCubit>(
                                                  context);

                                          cubit.verifyWalletPin(
                                              _pinController.text);
                                        }
                                      : null,
                                ),
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
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
