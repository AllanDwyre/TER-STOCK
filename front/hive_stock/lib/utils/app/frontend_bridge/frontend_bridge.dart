// import 'dart:io';
import 'package:dio/dio.dart';

import 'request.dart';

class FrontEndBrige {
  FrontEndBrige({this.isDebug}) {
    init();
  }

  final bool? isDebug;
  final Dio _dio = Dio();
  Dio get request => _dio;

  void init() {
    _dio.options
      ..baseUrl =
          isDebug ?? false ? ApiConfig.debugBaseUrl : ApiConfig.prodBaseUrl
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5)
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };
    // ..headers = {
    //   HttpHeaders.userAgentHeader: 'dio',
    //   'common-header': 'xx',
    // };
  }
}
