import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/product/repository/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepositoryImpl _productRepository;

  ProductCubit(this._productRepository) : super(const ProductInitial());

  Future<void> getProducts() async {
    emit(const ProductLoading());

    final products = await _productRepository.fetchProducts();

    if (products.isNotEmpty) {
      emit(ProductLoaded(products));
      return;
    }

    emit(const ProductError());
  }

  Future<void> reviewProduct({
    required String productId,
    required String review,
    required double rating,
  }) async {
    emit(const ProductLoading());

    final result = await _productRepository.reviewProduct(
      productId: productId,
      rating: rating,
      review: review,
    );

    if (result != null && result) {
      emit(const ProductReviewed());
      return;
    }

    emit(const ProductError());
  }
}
