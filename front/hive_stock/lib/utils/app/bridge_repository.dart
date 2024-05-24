import 'package:dio/dio.dart';
import 'package:hive_stock/utils/app/configuration.dart';

class BridgeRepository {
  late Dio request;

  BridgeRepository() {
    request = Dio();
    request.options
      ..baseUrl = ApiConfiguration.baseUrl
      ..connectTimeout = const Duration(seconds: 25)
      ..receiveTimeout = const Duration(seconds: 25)
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };
  }

  void getAuthentified(String token) =>
      request.options.headers["authorization"] = token;

  void getUnauthentified() => request.options.headers["authorization"] = "";
}
