part of 'product_review_cubit.dart';

abstract class ProductReviewState extends Equatable {
  const ProductReviewState();

  @override
  List<Object> get props => [];
}

class ProductReviewInitial extends ProductReviewState {
  const ProductReviewInitial();
}

class ProductReviewLoading extends ProductReviewState {
  const ProductReviewLoading();
}

class ProductReviewCreated extends ProductReviewState {
  const ProductReviewCreated();
}

class ProductReviewError extends ProductReviewState {
  const ProductReviewError();
}
