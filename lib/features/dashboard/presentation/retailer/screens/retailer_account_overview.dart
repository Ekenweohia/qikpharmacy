import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/widgets/account_statistics_row_widget.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/orders/order_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/products_from_wholesaler_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/shared/widgets/custom_header.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class RetailerAccountOverview extends StatefulWidget {
  const RetailerAccountOverview({Key? key}) : super(key: key);

  @override
  State<RetailerAccountOverview> createState() =>
      _RetailerAccountOverviewState();
}

class _RetailerAccountOverviewState extends State<RetailerAccountOverview> {
  @override
  void initState() {
    _getUserOrders();
    _getProducts();
    _getUserProducts();
    super.initState();
  }

  void _getUserOrders() {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.getUserOrders();
  }

  void _getUserProducts() {
    final categoryCubit = BlocProvider.of<UserProductCubit>(context);
    categoryCubit.getUserProducts();
  }

  void _getProducts() {
    final categoryCubit = BlocProvider.of<ProductCubit>(context);
    categoryCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColors.scaffoldBG,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(text: 'Account Overview'),
            const SizedBox(height: 33),
            const AccountStatisticsRowWidget(),
            const SizedBox(height: 33),
            Expanded(child: _productsWholesalers()),
          ],
        ),
      ),
    );
  }

  Widget _productsWholesalers() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularLoadingWidget());
        }

        if (state is ProductLoaded) {
          int length = state.products.length > 4 ? 4 : state.products.length;
          bool shouldShowMore = state.products.length > 4 ? true : false;

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(15, 40, 0, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Products from Wholesalers",
                      style: textStyle16Bold,
                    ),
                    const Spacer(),
                    if (shouldShowMore)
                      GestureDetector(
                        onTap: () => QikPharmaNavigator.push(
                            context, const ProductsFromWholesalerScreen()),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            'More',
                            style: textStyle15w700c,
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(child: _productsGrid(state.products, length))
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _productsGrid(final products, int length) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 17,
        children: [
          for (int i = 0; i < length; i++) ProductCard(product: products[i])
        ],
      ),
    );
  }
}
