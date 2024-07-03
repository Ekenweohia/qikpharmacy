import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';
import 'package:qik_pharma_mobile/core/models/request/create_product.dart';
import 'package:qik_pharma_mobile/features/product/repository/product_repository.dart';

part 'user_product_state.dart';

final productStatusList = ['Product status'];

class UserProductCubit extends Cubit<UserProductState> {
  final ProductRepositoryImpl _productRepository;

  UserProductCubit(this._productRepository) : super(const UserProductInitial());

  Future<void> getUserProducts() async {
    emit(const UserProductLoading());

    final products = await _productRepository.getUserProducts();

    emit(UserProductLoaded(products));
  }

  Future<void> createProduct({
    required CreateProduct req,
    required XFile? image,
  }) async {
    emit(const UserProductLoading());
    final result = await _productRepository.createProduct(
      req: req,
      image: image,
    );

    if (result.productId != null) {
      emit(const UserProductCreated());

      Future.delayed(const Duration(seconds: 1), () {
        getUserProducts();
      });
    } else {
      emit(const UserProductError());
    }
  }

  Future<void> updateProduct({
    required CreateProduct req,
    required XFile? image,
    required String productId,
  }) async {
    emit(const UserProductLoading());

    final result = await _productRepository.updateProduct(
      req: req,
      image: image,
      productId: productId,
    );

    if (result.productId != null) {
      emit(const UserProductCreated());

      Future.delayed(const Duration(seconds: 1), () {
        getUserProducts();
      });
    } else {
      emit(const UserProductError());
    }
  }

  Future<void> deleteProduct({
    required String productId,
  }) async {
    emit(const UserProductLoading());
    final result = await _productRepository.deleteProduct(productId: productId);

    if (result != null && result == true) {
      emit(const UserProductDeleted());

      Future.delayed(const Duration(seconds: 1), () {
        getUserProducts();
      });
    } else {
      emit(const UserProductError());
    }
  }
}
