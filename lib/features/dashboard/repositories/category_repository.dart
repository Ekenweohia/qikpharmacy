import 'package:qik_pharma_mobile/core/models/response/category_product.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';

abstract class CategoryRepository {
  Future<List<Category>> fetchCategories();
  Future<CategoryProducts> getProductsByCategory(String categoryId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  CategoryRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [];

    try {
      final response = await dioClient.get('product-categories');

      if (response == null || response.runtimeType == int) {
        return categories;
      }

      response['data'].forEach((category) {
        categories.add(Category.fromJson(category));
      });

      return categories;
    } catch (e) {
      return categories;
    }
  }

  @override
  Future<CategoryProducts> getProductsByCategory(String categoryId) async {
    try {
      final response = await dioClient.get('product-category/$categoryId');

      if (response == null || response.runtimeType == int) {
        return CategoryProducts();
      }

      final categoryProducts = CategoryProducts.fromJson(response['data']);

      return categoryProducts;
    } catch (e) {
      return CategoryProducts();
    }
  }
}
