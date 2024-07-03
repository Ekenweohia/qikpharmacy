import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/features/product/repository/product_repository.dart';

part 'dod_state.dart';

class DODCubit extends Cubit<DODState> {
  final ProductRepositoryImpl _productRepository;

  DODCubit(this._productRepository) : super(const DODInitial());

  Future<void> getDealsOfDay() async {
    emit(const DODLoading());

    final products = await _productRepository.getDealsOfDay();

    if (products.isNotEmpty) {
      emit(DODLoaded(products));
      return;
    }

    emit(const DODError());
  }
}
