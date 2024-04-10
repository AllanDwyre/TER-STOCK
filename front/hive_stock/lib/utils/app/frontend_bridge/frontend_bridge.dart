// import 'dart:io';
import 'package:dio/dio.dart';

import 'request.dart';

class FrontEndBrige {
  FrontEndBrige({this.isDebug}) {
    init();
  }

  final bool? isDebug;
  final Dio _dio = Dio();

  void init() {
    _dio.options
      ..baseUrl =
          isDebug ?? true ? ApiConfig.debugBaseUrl : ApiConfig.prodBaseUrl
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

  // TODO: find a way to verify if the request is used correctly ( verify data)
  //? is the best thing to do ?? ''
  Future<Response> post({required RequestsName request, Object? data}) async =>
      await _dio.post(ApiConfig.requestToString(request) ?? '', data: data);

  Future<Response> get({required RequestsName request, Object? data}) async =>
      await _dio.post(ApiConfig.requestToString(request) ?? '', data: data);

// TODO :  Add other forms of requests (update, download ...)
}
