import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/models/response/shipping_address.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/widget/payment_method_item.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/add_shipping_address_screen.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/checkout_successful_screen.dart';

enum PaymentOptions { debit, wallet }

class CheckoutScreen extends StatefulWidget {
  final CheckoutPayload payload;

  const CheckoutScreen({Key? key, required this.payload}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentOptions? paymentOptions = PaymentOptions.debit;

  int selectedIndex = 0;
  ShippingAddress selectedAddress = ShippingAddress();

  buttonEnabled() => selectedAddress.shippingAddressId != null;

  bool isLoading = false;

  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });

    _getShippingAddress();
    _getWalletDetails();
  }

  void _getShippingAddress() {
    final cubit = BlocProvider.of<ShippingCubit>(context);
    cubit.getShippingAddress();
  }

  void _getWalletDetails() {
    final cubit = BlocProvider.of<WalletCubit>(context);
    cubit.getWalletDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Checkout',
                    style: textStyle16Bold.copyWith(
                      color: AppCustomColors.textBlue,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 21),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.payload.cartItemIds!.length} Items in your cart',
                    style: textStyle13Light.copyWith(
                      color: AppCustomColors.textBlue.withOpacity(.45),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'TOTAL',
                        style: textStyle13w400.copyWith(
                          color: AppCustomColors.textBlue.withOpacity(.45),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$currency${widget.payload.amount}',
                        style: textStyle16Bold.copyWith(
                          color: AppCustomColors.textBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 11),
              Text(
                'Delivery Address',
                style: textStyle16Bold.copyWith(
                  color: AppCustomColors.textBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              BlocBuilder<ShippingCubit, ShippingState>(
                builder: (context, state) {
                  if (state is ShippingDetailsLoading) {
                    return const Center(
                      child: CircularLoadingWidget(),
                    );
                  }

                  if (state is ShippingDetailsLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        selectedAddress = state.shippingDetails[0];
                      });
                    });
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Column(
                          children: List.generate(
                            state.shippingDetails.length,
                            (index) => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<int>(
                                    value: index,
                                    groupValue: selectedIndex,
                                    activeColor: AppCustomColors.primaryColor,
                                    onChanged: (final value) {
                                      setState(() {
                                        selectedIndex = value!;
                                        selectedAddress =
                                            state.shippingDetails[index];
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.shippingDetails[index]
                                                  .phoneNumber ??
                                              '',
                                          style: textStyle16Light,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          state.shippingDetails[index]
                                                  .address ??
                                              '',
                                          style: textStyle16Light,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      QikPharmaNavigator.push(
                                        context,
                                        AddNewShippingAddressScreen(
                                          isEdit: true,
                                          shippingAddress:
                                              state.shippingDetails[index],
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.edit_outlined),
                                  )
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.add,
                              color: AppCustomColors.primaryColor,
                            ),
                            onPressed: () => QikPharmaNavigator.push(
                              context,
                              const AddNewShippingAddressScreen(),
                            ),
                            label: Text(
                              'Add Address',
                              style: textStyle14w400.copyWith(
                                color: AppCustomColors.primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: AppCustomColors.primaryColor,
                      ),
                      onPressed: () => QikPharmaNavigator.push(
                        context,
                        const AddNewShippingAddressScreen(),
                      ),
                      label: Text(
                        'Add Address',
                        style: textStyle14w400.copyWith(
                          color: AppCustomColors.primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Payment method',
                style: textStyle16Bold.copyWith(
                  color: AppCustomColors.textBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      child: ListTile(
                        title: PaymentMethodItem(
                          image: 'assets/images/icons/ic_mastercard.png',
                          title: 'Debit Card',
                          currency: currency,
                        ),
                        trailing: Radio<PaymentOptions>(
                          value: PaymentOptions.debit,
                          groupValue: paymentOptions,
                          onChanged: (PaymentOptions? value) {
                            setState(() {
                              paymentOptions = value;
                            });
                          },
                          activeColor: AppCustomColors.primaryColor,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () async {
                        paymentOptions = PaymentOptions.debit;

                        setState(() {});
                      },
                    ),
                    BlocConsumer<WalletCubit, WalletState>(
                      listener: (context, state) {
                        if (state is WalletLoading) {
                          setState(() {
                            isLoading = true;
                          });
                          return;
                        }

                        if (state is WalletDebited) {
                          QikPharmaNavigator.pushReplacement(
                              context, const CheckoutCompletedScreen());
                        }
                      },
                      builder: (context, state) {
                        if (state is WalletLoggedIn) {
                          return InkWell(
                            child: ListTile(
                              title: PaymentMethodItem(
                                image: 'assets/images/icons/ic_wallet.png',
                                title: 'eWallet',
                                walletBalance: '${state.wallet.balance}',
                                currency: currency,
                              ),
                              trailing: Radio<PaymentOptions>(
                                value: PaymentOptions.wallet,
                                groupValue: paymentOptions,
                                onChanged: (PaymentOptions? value) {
                                  if (state.wallet.balance! >=
                                      widget.payload.amount!) {
                                    setState(() {
                                      paymentOptions = value;
                                    });
                                  }
                                },
                                activeColor: AppCustomColors.primaryColor,
                              ),
                              contentPadding: const EdgeInsets.only(top: 16),
                            ),
                            onTap: () {
                              if (state.wallet.balance! >=
                                  widget.payload.amount!) {
                                setState(() {
                                  paymentOptions = PaymentOptions.wallet;
                                });
                              }
                            },
                          );
                        }

                        if (state is WalletLoading) {
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
              const Spacer(),
              BlocListener<CheckoutCubit, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    return;
                  }

                  setState(() {
                    isLoading = false;
                  });

                  if (state is CheckoutSuccessful) {
                    QikPharmaNavigator.pushReplacement(
                        context, const CheckoutCompletedScreen());
                  }
                },
                child: PrimaryButton(
                  title: 'Pay Now $currency${widget.payload.amount}',
                  onPressed: buttonEnabled()
                      ? () {
                          CheckoutPayload payload = CheckoutPayload(
                            amount: widget.payload.amount,
                            cartItemIds: widget.payload.cartItemIds,
                            shippingCompanyId: widget.payload.shippingCompanyId,
                          );

                          if (paymentOptions == PaymentOptions.debit) {
                            final cubit =
                                BlocProvider.of<CheckoutCubit>(context);
                            cubit.call(context, payload: payload);
                          }

                          if (paymentOptions == PaymentOptions.wallet) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return _debitWalletConfirmationDialog(
                                    widget.payload.amount!);
                              },
                            );
                          }
                        }
                      : null,
                  isEnabled: buttonEnabled(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _debitWalletConfirmationDialog(num amount) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_quetion.png',
                  width: 17,
                  height: 17,
                ),
                const SizedBox(width: 21),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Debit from eWallet',
                    style: textStyle15w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Text(
              'Confirm you are purchasing items worth $currency $amount using your eWallet',
              style: textStyle15w400,
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: PrimaryButton(
                      title: 'Cancel',
                      hasBorder: true,
                      borderColor: AppCustomColors.red,
                      buttonColor: Colors.white,
                      textColor: Colors.red,
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                ),
                const SizedBox(width: 26),
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: PrimaryButton(
                      title: 'Proceed',
                      onPressed: () {
                        final cubit = BlocProvider.of<WalletCubit>(context);

                        cubit.debitWallet(context, widget.payload);

                        setState(() {
                          isLoading = true;
                        });

                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
