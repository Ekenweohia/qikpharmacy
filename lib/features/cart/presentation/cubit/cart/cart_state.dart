part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CardInitial extends CartState {
  const CardInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final Cart cart;
  const CartLoaded(this.cart);
}

class CartError extends CartState {
  const CartError();
}

class CartItemCreated extends CartState {
  final bool result;
  const CartItemCreated(this.result);
}

class CartItemUpdated extends CartState {
  final bool result;
  const CartItemUpdated(this.result);
}

class CartItemDeleted extends CartState {
  final bool result;
  const CartItemDeleted(this.result);
}
