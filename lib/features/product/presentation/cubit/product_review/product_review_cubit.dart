import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/product/repository/product_repository.dart';

part 'product_review_state.dart';

class ProductReviewCubit extends Cubit<ProductReviewState> {
  final ProductRepositoryImpl _productRepository;

  ProductReviewCubit(this._productRepository)
      : super(const ProductReviewInitial());

  Future<void> reviewProduct({
    required String productId,
    required String review,
    required double rating,
  }) async {
    emit(const ProductReviewLoading());

    final result = await _productRepository.reviewProduct(
      productId: productId,
      rating: rating,
      review: review,
    );

    if (result != null && result) {
      emit(const ProductReviewCreated());

      return;
    }

    emit(const ProductReviewError());
  }
}
