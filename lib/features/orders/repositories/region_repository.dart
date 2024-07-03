import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/response/region.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

abstract class RegionRepository {
  Future<List<Region>> getAllRegions();
}

class RegionRepositoryImpl implements RegionRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  RegionRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  @override
  Future<List<Region>> getAllRegions() async {
    List<Region> regions = [];

    try {
      final response = await dioClient.get('regions');

      if (response == null || response.runtimeType == int) {
        return regions;
      }

      response['data'].forEach((category) {
        regions.add(Region.fromJson(category));
      });

      return regions;
    } catch (e) {
      return regions;
    }
  }
}
