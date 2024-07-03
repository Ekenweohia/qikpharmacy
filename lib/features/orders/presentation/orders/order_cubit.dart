import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/order.dart';
import 'package:qik_pharma_mobile/core/repositories/repositories.dart';

part 'order_state.dart';

// Delivered == 'completed'
// Processed == 'created'
// Canceled == 'canceled'
// Deleted == 'deleted'

Map<String, String> orderStatus = {
  'delivered': 'completed',
  'processing': 'created',
  'canceled': 'canceled',
  'deleted': 'deleted',
};

class OrderCubit extends Cubit<OrdersState> {
  final OrderRepositoryImpl _orderRepositoryImpl;

  OrderCubit(this._orderRepositoryImpl) : super(const OrdersInitial());

  void getUserOrders() async {
    emit(const OrdersLoading());

    List<Order> orders = await _orderRepositoryImpl.getUserOrders();

    emit(OrdersLoaded(orders));
  }
}
