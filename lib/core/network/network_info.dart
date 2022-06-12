import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);
  @override
  Future<bool> get isConnected async {
    final connection = await internetConnectionChecker.checkConnectivity();
    return connection == ConnectivityResult.none ? false : true;
  }
}
