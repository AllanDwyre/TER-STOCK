import 'package:dio/dio.dart';
import 'package:hive_stock/utils/app/configuration.dart';

class BridgeController {
  static late Dio request;

  static bridgeInitialization() {
    request = Dio();

    request.options
      ..baseUrl = ApiConfiguration.baseUrl
      ..connectTimeout =
          Duration(seconds: ApiConfiguration.isDebugMode ? 60 : 5)
      ..receiveTimeout =
          Duration(seconds: ApiConfiguration.isDebugMode ? 60 : 5)
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };
  }

  static void getAuthentified(String token) =>
      request.options.headers["authorization"] = token;

  static void getUnauthentified() =>
      request.options.headers["authorization"] = "";
}
