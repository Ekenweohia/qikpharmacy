import 'dart:async';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  Future<bool> connectionChecker() async {
    bool? isDeviceConnected;

    isDeviceConnected = await dataConnectionChecker.hasConnection
        .timeout(const Duration(seconds: 30));

    return isDeviceConnected;
  }

  @override
  Future<bool> get isConnected async => await connectionChecker();
}
