import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/features/product/presentation/product_details_screen.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String? currency;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });
  }

  void _navigateToProductScreen(context, {required Product product}) {
    QikPharmaNavigator.push(
      context,
      ProductDetailsScreen(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductScreen(context, product: widget.product),
      child: Container(
        width: 180,
        height: 250,
        padding: const EdgeInsets.only(bottom: 20),
        margin: const EdgeInsets.only(right: 17, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0XFFEBEBEB),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.07),
              blurRadius: 5,
              offset: const Offset(0.5, 0.75),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "Product ${DateTime.now()}",
              child: Container(
                width: double.infinity,
                height: 130,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: AppCustomColors.containerBG,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(
                  widget.product.productImagePath!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.name!,
                style: textStyle13Light.copyWith(
                  color: AppCustomColors.textBlue,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "$currency${widget.product.price}",
                style: textStyle16Bold.copyWith(
                  color: AppCustomColors.textBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
