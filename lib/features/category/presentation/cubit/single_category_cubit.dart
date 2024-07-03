import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/response/category_product.dart';
import 'package:qik_pharma_mobile/core/repositories/repositories.dart';

part 'single_category_state.dart';

class SingleCategoryProductsCubit extends Cubit<SingleCategoryProductsState> {
  final CategoryRepositoryImpl _categoryRepository;

  SingleCategoryProductsCubit(this._categoryRepository)
      : super(const SingleCategoryProductsInitial());

  Future<void> getProductsByCategory(String categoryId) async {
    emit(const SingleCategoryProductsLoading());

    final categories =
        await _categoryRepository.getProductsByCategory(categoryId);

    if (categories.products != null && categories.products!.isNotEmpty) {
      emit(SingleCategoryProductsLoaded(categories));
      return;
    }

    emit(const SingleCategoryProductsError());
  }
}
