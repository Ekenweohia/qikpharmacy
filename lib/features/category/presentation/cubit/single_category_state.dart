part of 'single_category_cubit.dart';

abstract class SingleCategoryProductsState extends Equatable {
  const SingleCategoryProductsState();

  @override
  List<Object> get props => [];
}

class SingleCategoryProductsInitial extends SingleCategoryProductsState {
  const SingleCategoryProductsInitial();
}

class SingleCategoryProductsLoading extends SingleCategoryProductsState {
  const SingleCategoryProductsLoading();
}

class SingleCategoryProductsLoaded extends SingleCategoryProductsState {
  final CategoryProducts categoryProducts;
  const SingleCategoryProductsLoaded(this.categoryProducts);
}

class SingleCategoryProductsError extends SingleCategoryProductsState {
  const SingleCategoryProductsError();
}
