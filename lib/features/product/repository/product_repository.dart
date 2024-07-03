import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/models/request/create_product.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/models.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();

  Future<void> getUserProducts();

  Future<bool?> reviewProduct({
    required String productId,
    required String review,
    required double rating,
  });

  Future<Product> createProduct({
    required CreateProduct req,
    required XFile? image,
  });

  Future<Product> updateProduct({
    required CreateProduct req,
    required XFile? image,
    required String productId,
  });

  Future<dynamic> deleteProduct({required String productId});

  Future<List<Product>> getDealsOfDay();
}

class ProductRepositoryImpl implements ProductRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  ProductRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];

    try {
      final response = await dioClient.get(
        'products',
      );
      

      if (response == null || response.runtimeType == int) {
        return products;
      }
      

      response['data']['rows'].forEach((product) {
        products.add(Product.fromJson(product));
      });
      return products;
    } catch (e) {
      return products;
    }
  }

  @override
  Future<List<Product>> getUserProducts() async {
    List<Product> products = [];

    try {
      final response =
          await dioClient.get('product/user/${await offlineClient.userId}');

      if (response == null || response.runtimeType == int) {
        return products;
      }

      response['data']['rows'].forEach((product) {
        products.add(Product.fromJson(product));
      });
      return products;
    } catch (e) {
      return products;
    }
  }

  @override
  Future<bool?> reviewProduct({
    required String productId,
    required String review,
    required double rating,
  }) async {
    try {
      final response = await dioClient.post(
        'product/review/$productId',
        body: {
          'userId': (await offlineClient.userId),
          'review': review,
          'rating': rating,
        },
      );

      if (response == null || response.runtimeType == int) {
        return null;
      }
      logDebug('review response $response');

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product> createProduct({
    required CreateProduct req,
    required XFile? image,
  }) async {
    try {
      req.userId = (await offlineClient.userId);

      String fileName = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      formData.fields.addAll([MapEntry('regions[0]', req.regions!)]);

      formData.fields
          .addAll([MapEntry('productCategoryId', req.productCategoryId!)]);
      formData.fields.addAll([MapEntry('userId', req.userId!)]);
      formData.fields.addAll([MapEntry('name', req.name!)]);
      formData.fields.addAll([MapEntry('price', req.price!.toString())]);
      formData.fields
          .addAll([MapEntry('discount', (req.discount ?? 0).toString())]);

      formData.fields.addAll([MapEntry('description', req.description!)]);
      formData.fields.addAll([MapEntry('quantity', req.quantity!.toString())]);
      formData.fields.addAll([MapEntry('isActive', '${req.isActive}')]);
      formData.fields
          .addAll([MapEntry('displayDiscount', '${req.displayDiscount}')]);
      formData.fields
          .addAll([MapEntry('displayReviews', '${req.displayReviews}')]);
      formData.fields
          .addAll([MapEntry('needsPrescription', '${req.needsPrescription}')]);

      final response = await dioClient.post('product', body: formData);

      if (response == null || response.runtimeType == int) {
        return Product();
      }

      final product = Product.fromJson(response['data']['rows']);

      return product;
    } catch (e) {
      return Product();
    }
  }

  @override
  Future<Product> updateProduct({
    required CreateProduct req,
    required XFile? image,
    required String productId,
  }) async {
    try {
      req.userId = (await offlineClient.userId);

      String fileName = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      formData.fields.addAll([MapEntry('regions[0]', req.regions!)]);

      formData.fields
          .addAll([MapEntry('productCategoryId', req.productCategoryId!)]);
      formData.fields.addAll([MapEntry('name', req.name!)]);

      formData.fields.addAll([MapEntry('price', req.price!.toString())]);

      formData.fields
          .addAll([MapEntry('discount', (req.discount ?? 0).toString())]);

      formData.fields.addAll([MapEntry('description', req.description!)]);
      formData.fields.addAll([MapEntry('quantity', req.quantity!.toString())]);
      formData.fields.addAll([MapEntry('isActive', '${req.isActive}')]);
      formData.fields
          .addAll([MapEntry('displayDiscount', '${req.displayDiscount}')]);
      formData.fields
          .addAll([MapEntry('displayReviews', '${req.displayReviews}')]);
      formData.fields
          .addAll([MapEntry('needsPrescription', '${req.needsPrescription}')]);
      formData.fields.addAll([MapEntry('oldImageUrl', req.imageUrl!)]);

      final response =
          await dioClient.put('product/$productId', body: formData);

      if (response == null || response.runtimeType == int) {
        return Product();
      }

      final product = Product.fromJson(response['data']['rows']);

      return product;
    } catch (e) {
      return Product();
    }
  }

  @override
  Future<bool?> deleteProduct({required String productId}) async {
    final response = await dioClient.delete('product/$productId');

    if (response == null || response.runtimeType == int) {
      return null;
    }

    return true;
  }

  @override
  Future<List<Product>> getDealsOfDay() async {
    List<Product> products = [];

    try {
      final response = await dioClient.get('products?discounted=true');
      // print("Products ${response}");

      if (response == null || response.runtimeType == int) {
        return products;
      }

      response['data']['rows'].forEach((product) {
        products.add(Product.fromJson(product));
      });
      // print("Products ${response}");
      return products;
    } catch (e) {
      return products;
    }
  }
}
