import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cart_screen.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:qik_pharma_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:qik_pharma_mobile/features/product/presentation/widget/product_review_item.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_rating_stats_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double totalRating = 0;
  int numberOfReviews = 0;
  int numberOfRatings = 0;

  String? currency;

  void _navigateToCartScreen() => QikPharmaNavigator.push(
        context,
        const CartScreen(fromHome: false),
      );

  @override
  void initState() {
    if (widget.product.productReviews != null &&
        widget.product.productReviews!.isNotEmpty) {
      setState(() {
        totalRating = widget.product.productReviews!.fold<double>(
            0,
            (prev, next) =>
                (prev + (next.rating ?? 0)) /
                widget.product.productReviews!.length);

        numberOfRatings = widget.product.productReviews!
            .where((e) => e.rating != null)
            .length;

        numberOfReviews = widget.product.productReviews!
            .where((e) => e.review != null)
            .length;
      });
    }

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
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
                  const Spacer(),
                  GestureDetector(
                    onTap: () => QikPharmaNavigator.push(
                      context,
                      const NotificationsScreen(
                        fromHome: false,
                      ),
                    ),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black.withOpacity(.6),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () => QikPharmaNavigator.push(
                      context,
                      const CartScreen(
                        fromHome: false,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/icons/cart_icon.png',
                      height: 26,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.product.name!,
                style: textStyle20Bold.copyWith(
                  color: AppCustomColors.textBlue,
                  fontSize: 22,
                ),
              ),
              if (widget.product.productImagePath != null)
                const SizedBox(height: 38),
              if (widget.product.productImagePath != null)
                Container(
                  width: double.infinity,
                  height: 140,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: AppCustomColors.containerBG,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.product.productImagePath!),
                ),
              const SizedBox(height: 29),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currency${widget.product.price}',
                        style: textStyle17Bold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartItemCreated) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const SuccessDialog(
                              message: 'Successfully added to cart!',
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: CircularLoadingWidget(),
                          ),
                        );
                      }

                      return TextButton.icon(
                        onPressed: () async {
                          final cartCubit = BlocProvider.of<CartCubit>(context);

                          await cartCubit.addToCart(
                              productId: widget.product.productId!);
                        },
                        icon: const Icon(
                          Icons.add_box_outlined,
                          color: AppCustomColors.primaryColor,
                        ),
                        label: Text(
                          'Add to cart',
                          style: textStyle14w400.copyWith(
                            color: AppCustomColors.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Divider(color: Colors.black.withOpacity(.3)),
              const SizedBox(height: 47),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Details',
                        style: textStyle16Grey.copyWith(
                          color: AppCustomColors.textBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.product.description!,
                        style: textStyle14Light.copyWith(
                          color: const Color(0XFF090F47).withOpacity(.45),
                        ),
                      ),
                      const SizedBox(height: 98),
                      if (widget.product.productReviews != null &&
                          widget.product.productReviews!.isNotEmpty)
                        reviewSection(widget.product.productReviews!),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                title: 'GO TO CART',
                onPressed: () => _navigateToCartScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reviewSection(List<ProductReviews> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating and Reviews',
          style: textStyle16Grey.copyWith(
            color: AppCustomColors.textBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$totalRating',
                      style: textStyle30Bold.copyWith(
                        fontSize: 33,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.star, color: Colors.amber[700]),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '$numberOfRatings Ratings',
                  style: textStyle14w400.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$numberOfReviews Reviews',
                  style: textStyle14w400.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 17),
            SizedBox(
              height: 90,
              child: VerticalDivider(
                color: Colors.black.withOpacity(.3),
              ),
            ),
            const SizedBox(width: 17),
            CustomRatingStatsWidget(productReviews: reviews)
          ],
        ),
        const SizedBox(height: 34),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          child: ListView.separated(
            itemBuilder: (context, index) =>
                ProductReviewItem(productReview: reviews[index]),
            separatorBuilder: (context, index) =>
                Divider(color: Colors.black.withOpacity(.3)),
            itemCount: reviews.length,
          ),
        ),
      ],
    );
  }
}
