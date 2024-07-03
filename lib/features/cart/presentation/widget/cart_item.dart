import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/cart/cart_cubit.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:qik_pharma_mobile/core/models/response/cart.dart';

class CartItem extends StatefulWidget {
  final CartItems item;
  final ValueChanged<int> updatedCount;

  const CartItem({
    Key? key,
    required this.item,
    required this.updatedCount,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int count = 0;

  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });

    setState(() {
      count = widget.item.qty ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.item.product!.productImagePath != null)
                Container(
                  height: 91,
                  width: 91,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppCustomColors.containerBG,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(widget.item.product!.productImagePath!),
                ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.product?.name ?? '',
                            maxLines: 2,
                            style: textStyle14w400.copyWith(
                              color: AppCustomColors.textBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            final cartCubit =
                                BlocProvider.of<CartCubit>(context);

                            cartCubit.deleteFromCart(
                              productId: widget.item.product!.productId!,
                            );
                          },
                          child: Image.asset(
                            "assets/images/icons/ic_rounded_close.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (currency != null)
                          Text(
                            currency! + widget.item.product!.price.toString(),
                            style: textStyle17Bold.copyWith(
                              color: AppCustomColors.textBlue,
                            ),
                          ),
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                AppCustomColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: count <= 1
                                        ? AppCustomColors.lightTextColor
                                            .withOpacity(0.2)
                                        : AppCustomColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                onTap: () {
                                  if (count > 1) {
                                    setState(() {
                                      count--;
                                      widget.updatedCount.call(count);
                                    });

                                    final cartCubit =
                                        BlocProvider.of<CartCubit>(context);
                                    cartCubit.updateToCart(
                                      productId:
                                          widget.item.product!.productId!,
                                      quantity: count,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(count.toString(), style: textStyle16Bold),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: AppCustomColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    count++;
                                    widget.updatedCount.call(count);
                                  });

                                  final cartCubit =
                                      BlocProvider.of<CartCubit>(context);

                                  cartCubit.updateToCart(
                                    productId: widget.item.product!.productId!,
                                    quantity: count,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
