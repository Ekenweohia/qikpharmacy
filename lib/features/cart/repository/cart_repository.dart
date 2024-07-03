import 'package:qik_pharma_mobile/core/models/response/cart.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';

abstract class CartRepository {
  Future<Cart> getCart();

  Future<bool?> addToCart({required String productId});

  Future<bool?> updateToCart({
    required String productId,
    required int quantity,
  });

  Future<bool?> deleteFromCart({required String productId});

  Future<List<Logistics>> getLogistics();
}
