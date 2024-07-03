import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/products_from_wholesaler_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class ProductFromWholeSalersWidget extends StatelessWidget {
  const ProductFromWholeSalersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularLoadingWidget(),
          );
        }
        if (state is ProductLoaded) {
          final products = state.products;
          final showMore = products.length > 4;

          return Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products from Wholesalers',
                      style: textStyle16Bold.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (showMore)
                      GestureDetector(
                        onTap: () => QikPharmaNavigator.push(
                          context,
                          const ProductsFromWholesalerScreen(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            'More',
                            style: textStyle14w400.copyWith(
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 17),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      showMore ? 4 : products.length,
                      (index) => ProductCard(product: products[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
