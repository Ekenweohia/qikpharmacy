import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class FeaturedSellersWidget extends StatelessWidget {
  final bool isUser;
  const FeaturedSellersWidget({Key? key, this.isUser = true}) : super(key: key);

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
          final filteredList = <Product>[...products];
          final ids = <String?>{};

          filteredList.retainWhere((e) => ids.add(e.user?.userId));

          return Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isUser ? 'Featured Retailers' : 'Featured Wholesalers',
                      style: textStyle16Bold.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final p in filteredList.where((e) => isUser
                          ? e.user?.retailer != null
                          : e.user?.distributor != null))
                        if (p.user != null)
                          Container(
                            height: 130,
                            margin: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.07),
                                        blurRadius: 5,
                                        offset: const Offset(0.5, 0.75),
                                      )
                                    ],
                                  ),
                                  child: p.user?.imagePath != null
                                      ? Image.network(p.user!.imagePath!)
                                      : const Icon(Icons.person),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  isUser
                                      ? p.user!.retailer!.companyName!
                                      : p.user!.distributor!.companyName!,
                                  style: textStyle13Light,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                    ],
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
