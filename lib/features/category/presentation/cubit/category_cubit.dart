import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/repositories/repositories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepositoryImpl _categoryRepository;

  CategoryCubit(this._categoryRepository) : super(const CategoryInitial());

  Future<void> getCategories() async {
    emit(const CategoryLoading());

    final categories = await _categoryRepository.fetchCategories();

    if (categories.isNotEmpty) {
      emit(CategoryLoaded(categories));
      return;
    }

    emit(const CategoryError());
  }
}
