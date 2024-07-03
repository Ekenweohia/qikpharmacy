import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/cart.dart';
import 'package:qik_pharma_mobile/features/cart/repository/cart_repository_impl.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepositoryImpl _cartRepository;

  CartCubit(this._cartRepository) : super(const CardInitial());

  Future<void> getCart() async {
    emit(const CartLoading());

    final cart = await _cartRepository.getCart();

    if (cart.cartItems != null && cart.cartItems!.isNotEmpty) {
      emit(CartLoaded(cart));
      return;
    }

    emit(const CartError());
  }

  Future<void> addToCart({required String productId}) async {
    emit(const CartLoading());

    final result = await _cartRepository.addToCart(productId: productId);

    if (result != null && result) {
      emit(CartItemCreated(result));
      return;
    }

    emit(const CartError());
  }

  Future<void> updateToCart({
    required String productId,
    required int quantity,
  }) async {
    emit(const CartLoading());

    await _cartRepository.updateToCart(
      productId: productId,
      quantity: quantity,
    );

    getCart();
  }

  Future<void> deleteFromCart({required String productId}) async {
    emit(const CartLoading());

    await _cartRepository.deleteFromCart(
      productId: productId,
    );

    getCart();
  }
}
