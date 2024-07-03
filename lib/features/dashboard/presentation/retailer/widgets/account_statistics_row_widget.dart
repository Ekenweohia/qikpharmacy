import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/dashboard/presentation/retailer/widgets/account_overview_stats_widget.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/my_orders.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/orders/order_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/retailer_products_list.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

class AccountStatisticsRowWidget extends StatelessWidget {
  const AccountStatisticsRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrdersState>(
      builder: (context, ordersState) {
        return BlocBuilder<UserProductCubit, UserProductState>(
          builder: (context, productState) {
            if (ordersState is OrdersLoading ||
                productState is UserProductLoading) {
              return const Center(child: CircularLoadingWidget());
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (productState is UserProductLoaded)
                  AccountOverviewStatsWidget(
                    icon: Icons.assignment_turned_in,
                    value: productState.products.length,
                    label: 'All Products',
                    onTap: () => QikPharmaNavigator.push(
                      context,
                      const RetailerProductsList(),
                    ),
                  ),
                if (ordersState is OrdersLoaded)
                  AccountOverviewStatsWidget(
                    icon: Icons.location_searching_rounded,
                    value: ordersState.orders
                        .where((e) => e.status != orderStatus['completed'])
                        .toList()
                        .length,
                    label: 'Track Orders',
                    onTap: () => QikPharmaNavigator.push(
                      context,
                      const MyOrderScreen(),
                    ),
                  ),
                if (ordersState is OrdersLoaded)
                  AccountOverviewStatsWidget(
                    icon: Icons.receipt_long,
                    value: ordersState.orders.length,
                    label: 'Total Orders',
                    onTap: () => QikPharmaNavigator.push(
                      context,
                      const MyOrderScreen(),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
