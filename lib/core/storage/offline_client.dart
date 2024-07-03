import 'package:qik_pharma_mobile/core/storage/local_keys.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineClient {
  Future<String?> getString(String key) async =>
      (await SharedPreferences.getInstance()).getString(key);

  Future<bool> setString(String key, String value) async =>
      await (await SharedPreferences.getInstance()).setString(key, value);

  Future<bool?> getBool(String key) async =>
      (await SharedPreferences.getInstance()).getBool(key);

  Future<bool> setBool(String key, bool value) async =>
      await (await SharedPreferences.getInstance()).setBool(key, value);

  Future<bool> clearData(String key) async =>
      await (await SharedPreferences.getInstance()).remove(key);

  String? get accessToken => Constants.apiKey;

  Future<String>? get userId async => Future.value(await getString(kUserId));

  Future<bool> get isWalletLoggedIn async =>
      Future.value(await getBool(kWalletLoggedIn) ?? false);

  Future<String> get baseUrl async =>
      Future.value(await getString(kBaseUrl) ?? '');

  Future<String> get currency async =>
      Future.value(await getString(kCurrency) ?? '');

  Future<String> get paystackKey async =>
      Future.value(await getString(kPaystackPublicKey) ?? '');
}
