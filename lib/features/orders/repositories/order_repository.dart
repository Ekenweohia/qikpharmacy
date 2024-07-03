import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/response/order.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

Map<String, String> orderStaatus = {
  'Awaiting payments': 'awaiting-payments',
  'processing': 'created',
  'canceled': 'canceled',
  'deleted': 'deleted',
};

abstract class OrderRepository {
  Future<List<Order>> getUserOrders();
}

class OrderRepositoryImpl implements OrderRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  OrderRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<Order>> getUserOrders() async {
    List<Order> orders = [];

    try {
      final response =
          await dioClient.get('order/${await offlineClient.userId}');

      if (response == null || response.runtimeType == int) {
        return orders;
      }

      response['data'].forEach((category) {
        orders.add(Order.fromJson(category));
      });

      return orders;
    } catch (e) {
      return orders;
    }
  }
}

List<Order> dummyOrders = [
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'completed',
  ),
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'awaiting-payments',
  ),
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'canceled',
  ),
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'created',
  ),
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'deleted',
  ),
  Order(
    orderId: '12bjb32b4bc5kc4gn47',
    subTotal: 112,
    trackingNumber: 'quhy27364765nt64t5t546t5',
    orderItems: [
      OrderItems(),
      OrderItems(),
      OrderItems(),
      OrderItems(),
    ],
    createdAt: DateTime.now().toUtc().toString(),
    status: 'processed',
  )
];
