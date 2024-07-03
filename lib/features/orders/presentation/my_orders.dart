import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/order.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/order_detail.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/orders/order_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/review_product_screen.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  ValueChanged<String> selectedTab = (value) => orderStatus.keys.first;
  ValueNotifier<String> selectedKey = ValueNotifier(orderStatus.keys.first);
  ValueNotifier<String> selectedValue = ValueNotifier(orderStatus.values.first);

  final orderStatusKeys = orderStatus.keys.toList();
  final orderStatusValues = orderStatus.values.toList();

  String? currency;

  @override
  void initState() {
    super.initState();

    _getUserOrders();

    Future.delayed(Duration.zero, () async {
      currency = await Helper.currency();
      setState(() {});
    });
  }

  void _getUserOrders() {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),
              Text('My Orders', style: textStyle24Bold),
              const SizedBox(height: 25),
              _buildTabBarHeader(),
              const SizedBox(height: 20),
              Expanded(child: _buildTabBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          orderStatusKeys.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedKey.value = orderStatusKeys[index];
                selectedValue.value = orderStatusValues[index];

                selectedTab.call(selectedKey.value);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedKey.value == orderStatusKeys[index]
                    ? AppCustomColors.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                orderStatusKeys[index].toSentenceCase,
                style: textStyle15w300.copyWith(
                  color: selectedKey.value == orderStatusKeys[index]
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBody(BuildContext context) {
    return BlocBuilder<OrderCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersLoaded) {
          final orderList = state.orders;

          if (orderList.isEmpty ||
              orderList
                  .where((e) => e.status == selectedValue.value)
                  .toList()
                  .isEmpty) {
            return Center(
              child: Text(
                'No orders yet!',
                style: textStyle15w300,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                for (final order in orderList)
                  order.status == selectedValue.value
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      'Order No : ${order.orderId!.toUpperCase().substring(0, 8)}',
                                      style: textStyle17Bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateFormat('yyyy-MM-dd')
                                            .parse(order.createdAt!)),
                                    style: textStyle15w300,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('Tracking number: ',
                                      style: textStyle15w300),
                                  const SizedBox(width: 10),
                                  Text(
                                      '${order.trackingNumber}'
                                          .toUpperCase()
                                          .substring(0, 8),
                                      style: textStyle15w500Black),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('Quantity: ',
                                          style: textStyle15w300),
                                      Text(
                                        '${order.orderItems?.length ?? 0}',
                                        style: textStyle15w500Black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Total Amount: ',
                                        style: textStyle15w300,
                                      ),
                                      Text(
                                        '$currency'
                                        '${order.subTotal}',
                                        style: textStyle15w500Black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 23),
                              _bottomRow(selectedValue.value, order),
                              const SizedBox(height: 23),
                            ],
                          ),
                        )
                      : const SizedBox(),
              ],
            ),
          );
        }

        return Text(
          'No orders yet!',
          style: textStyle15w300,
        );
      },
    );
  }

  Widget _bottomRow(String selectedValue, Order order) {
    switch (selectedValue) {
      case 'completed':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(
              title: 'Details',
              onPressed: () => QikPharmaNavigator.push(
                context,
                OrderDetailScreen(order: order),
              ),
            ),
            Text(
              'Delivered',
              style: textStyle15w500Black.copyWith(
                color: AppCustomColors.primaryColor,
              ),
            ),
            OutlineButton(
              title: 'Review',
              onPressed: () => QikPharmaNavigator.push(
                context,
                ReviewProductScreen(product: order.orderItems![0].product!),
              ),
            ),
          ],
        );
      case 'awaiting-payments':
        return Align(
          alignment: Alignment.centerLeft,
          child: OutlineButton(
            title: 'Details',
            onPressed: () => QikPharmaNavigator.push(
              context,
              OrderDetailScreen(order: order),
            ),
          ),
        );
      case 'created':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(
              title: 'Details',
              onPressed: () => QikPharmaNavigator.push(
                context,
                OrderDetailScreen(order: order),
              ),
            ),
            Text(
              'Processing',
              style: textStyle15w500Black.copyWith(
                color: AppCustomColors.red,
              ),
            ),
          ],
        );

      case 'canceled':
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Canceled',
            style: textStyle15w500Black.copyWith(
              color: AppCustomColors.red,
            ),
          ),
        );

      case 'deleted':
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Deleted',
            style: textStyle15w500Black.copyWith(
              color: AppCustomColors.red,
            ),
          ),
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(
              title: 'Details',
              onPressed: () => QikPharmaNavigator.push(
                context,
                OrderDetailScreen(order: order),
              ),
            ),
            Text(
              'Order Processed',
              style: textStyle15w500Black.copyWith(
                color: AppCustomColors.primaryColor,
              ),
            ),
          ],
        );
    }
  }
}
