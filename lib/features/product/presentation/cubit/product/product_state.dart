part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);
}

class ProductError extends ProductState {
  const ProductError();
}

class ProductReviewed extends ProductState {
  const ProductReviewed();
}
