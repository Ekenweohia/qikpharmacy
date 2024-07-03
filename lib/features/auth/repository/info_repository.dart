import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/models/response/company_type.dart';
import 'package:qik_pharma_mobile/core/models/response/medications.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';

import '../../../core/models/response/country.dart';

abstract class InfoRepository {
  Future<List<Country>> getCountries();
  Future<List<CompanyType>> getCompanyTypes();
  Future<List<Medications>> getMedications();
}

class InfoRepositoryImpl extends InfoRepository {
  final DioClient dioClient;
  final OfflineClient offlineClient;

  InfoRepositoryImpl({
    required this.dioClient,
    required this.offlineClient,
  });

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/db/countries.json");
  }

  @override
  Future<List<Country>> getCountries() async {
    List<Country> countriesList = [];
    try {
      String jsonString = await _loadFromAsset();

      final jsonResponse = jsonDecode(jsonString).cast<Map<String, dynamic>>();

      countriesList =
          jsonResponse.map<Country>((json) => Country.fromJson(json)).toList();

      return countriesList.toSet().toList();
    } catch (e) {
      return countriesList;
    }
  }

  @override
  Future<List<CompanyType>> getCompanyTypes() async {
    List<CompanyType> companyTypeList = [];

    try {
      final response = await dioClient.get('companytypes');

      var addressList = response['data'].toList();

      addressList.forEach((jsonModel) {
        companyTypeList.add(CompanyType.fromJson(jsonModel));
      });

      return companyTypeList;
    } catch (e) {
      return companyTypeList;
    }
  }

  @override
  Future<List<Medications>> getMedications() async {
    List<Medications> medicationsList = [];

    try {
      final response = await dioClient.get('typeofmedications');

      var addressList = response['data'].toList();

      addressList.forEach((jsonModel) {
        medicationsList.add(Medications.fromJson(jsonModel));
      });

      return medicationsList;
    } catch (e) {
      return medicationsList;
    }
  }
}
