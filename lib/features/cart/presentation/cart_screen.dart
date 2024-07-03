import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qik_pharma_mobile/core/models/request/checkout_payload.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/checkout_screen.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/logistics/logistics_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/widget/cart_item.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/widget/empty_cart_widget.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/widget/payment_summary_widget.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/widget/select_logistics_widget.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/products_from_wholesaler_screen.dart';
import 'package:qik_pharma_mobile/shared/extensions/string_extension.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/primary_button.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class CartScreen extends StatefulWidget {
  final bool fromHome;

  const CartScreen({Key? key, this.fromHome = true}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 1;
  final selectedLogistics = ValueNotifier<Logistics?>(null);
  buttonEnabled() => selectedLogistics.value != null;

  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });

    _getCart();
    _getProducts();
    _getLogistics();
  }

  void _getCart() {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.getCart();
  }

  void _getProducts() {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProducts();
  }

  void _getLogistics() {
    final logisticsCubit = BlocProvider.of<LogisticsCubit>(context);
    logisticsCubit.getLogistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  if (!widget.fromHome)
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: AppCustomColors.textBlue,
                      ),
                    ),
                  if (!widget.fromHome) const SizedBox(width: 21),
                  Text(
                    "Your Cart",
                    style: textStyle16Bold.copyWith(
                      color: AppCustomColors.textBlue,
                    ),
                  )
                ],
              ),
              BlocBuilder<LogisticsCubit, LogisticsState>(
                builder: (context, logisticsState) {
                  return BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading ||
                          logisticsState is LogisticsLoading) {
                        return const Center(child: CircularLoadingWidget());
                      }

                      if (state is CartLoaded) {
                        final items = state.cart.cartItems ?? [];

                        double discount = 0;

                        state.cart.cartItems!.map((e) {
                          if (e.product?.discount != null) {
                            final perItemDiscount =
                                (e.price! * e.product!.discount!) / 100;

                            discount = discount + perItemDiscount;
                          }
                        }).toList();

                        final total = state.cart.subTotal! - discount;

                        double pricePerKm =
                            selectedLogistics.value?.pricePerKm ?? 0;

                        final totalCost =
                            (total + pricePerKm).toStringAsFixed(2);

                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${items.length}${' Item'.pluralize(items.length)} in your cart',
                                    style: textStyle13Light.copyWith(
                                      color: AppCustomColors.textBlue
                                          .withOpacity(.45),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => QikPharmaNavigator.push(
                                      context,
                                      const ProductsFromWholesalerScreen(),
                                    ),
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppCustomColors.primaryColor,
                                    ),
                                    label: Text(
                                      "Add more",
                                      style: textStyle14w400.copyWith(
                                        color: AppCustomColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  children: [
                                    for (final item in items)
                                      CartItem(
                                        item: item,
                                        updatedCount: (value) {
                                          setState(() {
                                            count = value;
                                          });
                                        },
                                      ),
                                    const SizedBox(height: 18),
                                    if (logisticsState is LogisticsLoaded)
                                      SelectLogisticsOverlay(
                                        logistics: logisticsState.logistics,
                                        selectedLogistics: (value) {
                                          setState(() {
                                            selectedLogistics.value = value;
                                          });
                                        },
                                      ),
                                    const SizedBox(height: 24),
                                    PaymentSummaryWidget(
                                      discount: discount,
                                      subTotal: state.cart.subTotal ?? 0,
                                      total: total,
                                      selectedLogistics: selectedLogistics,
                                      currency: currency,
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              PrimaryButton(
                                title: 'Place Order @ $currency $totalCost',
                                isEnabled: buttonEnabled(),
                                onPressed: buttonEnabled()
                                    ? () {
                                        List<String> cartIds = [];
                                        items
                                            .map((e) =>
                                                cartIds.add(e.cartItemId!))
                                            .toList();

                                        final payload = CheckoutPayload(
                                          amount: num.parse(totalCost),
                                          cartItemIds: [...cartIds],
                                          shippingCompanyId: selectedLogistics
                                                  .value?.logisticsCompanyId ??
                                              '',
                                        );

                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: CheckoutScreen(
                                              payload: payload,
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        );
                      }

                      return const EmptyCartWidget();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
