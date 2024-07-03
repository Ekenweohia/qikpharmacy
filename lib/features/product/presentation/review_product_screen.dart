import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/product_reviewed_successfully_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class ReviewProductScreen extends StatefulWidget {
  final Product product;

  const ReviewProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  final TextEditingController _commentController = TextEditingController();

  double productRating = 0;

  buttonEnabled() => productRating > 0 && _commentController.text.isNotEmpty;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductReviewed) {
              QikPharmaNavigator.pushReplacement(
                context,
                const ProductReviewedSuccessfullyScreen(),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Text(
                          "Cancel",
                          style: textStyle16Bold.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 46),
                      Text("Rate this product", style: textStyle16Bold),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    color: const Color.fromRGBO(242, 242, 242, 0.58),
                    width: double.infinity,
                    height: 109,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 81,
                          height: 81,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                widget.product.productImagePath.toString(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.product.name.toString(),
                                    maxLines: 2,
                                    style: textStyle14w400.copyWith(
                                      color: AppCustomColors.textBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Spacer(),
                              Text(
                                "$currency ${widget.product.price}",
                                style: textStyle17Bold.copyWith(
                                  fontSize: 18,
                                  color: AppCustomColors.textBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 47),
                  Text(
                    'How  would you rate this product',
                    style: textStyle16Bold.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      initialRating: productRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          productRating = rating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Do you want to add suggestions to sellers and buyers? Give advice to all of us! ',
                    textAlign: TextAlign.center,
                    style: textStyle16Bold.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _commentController,
                      maxLines: 7,
                      cursorColor: AppCustomColors.primaryColor,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        hintText: 'Write a comment',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    title: 'Submit',
                    isEnabled: buttonEnabled(),
                    onPressed: buttonEnabled()
                        ? () {
                            final cubit =
                                BlocProvider.of<ProductCubit>(context);

                            cubit.reviewProduct(
                              productId: widget.product.productId!,
                              review: _commentController.text,
                              rating: productRating,
                            );
                          }
                        : null,
                    loading: state is ProductLoading,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
