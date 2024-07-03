import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/wallet_credit_success_screen.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/credit_wallet_dialog.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_history_item.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      body: SafeArea(
        child: BlocConsumer<WalletCubit, WalletState>(
          listener: (context, state) {
            if (state is WalletCredited) {
              QikPharmaNavigator.pushReplacement(
                  context, const WalletCreditSuccessScreen());
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (state is WalletLoggedIn)
                          Expanded(
                            // height: MediaQuery.of(context).size.height,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wallet",
                                    style: textStyle20Bold.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 48),
                                  Text(
                                    'Account Overview',
                                    style: textStyle20,
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 119,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 35, 26, 23),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (currency != null)
                                                Text(
                                                  currency! +
                                                      Helper.formatAmountString(
                                                          state.wallet.balance
                                                              .toString()),
                                                  style: textStyle24Bold,
                                                  maxLines: 1,
                                                ),
                                              const SizedBox(height: 6),
                                              Text(
                                                'Current Balance',
                                                style: textStyle11Light,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) =>
                                                  const CreditWalletDialog(),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(13),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppCustomColors.primaryColor,
                                                  Color.fromARGB(255, 2, 34, 3)
                                                ],
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 19),
                                  SizedBox(
                                    width: 320,
                                    child: Divider(
                                      thickness: 1.5,
                                      color: Colors.black.withOpacity(.1),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Transaction History',
                                    style: textStyle13Light.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  if (state.wallet.walletHistories != null &&
                                      state.wallet.walletHistories!.isNotEmpty)
                                    Column(
                                      children: [
                                        Container(
                                          width: 320,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.2,
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 29, 14, 29),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ListView.builder(
                                            itemCount: state
                                                .wallet.walletHistories!.length,
                                            itemBuilder: (context, index) {
                                              final item = state.wallet
                                                  .walletHistories!.reversed
                                                  .toList()[index];

                                              return WalletHistoryItem(
                                                history: item,
                                                currency: currency,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'You have no transactions yet!',
                                      style: textStyle13Light,
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
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
