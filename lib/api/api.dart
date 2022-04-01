import 'dart:async';
import 'package:dio/dio.dart';
import '../utils/constants.dart';
import 'rest_client.dart';

class API {
  static final API _api = API._internal();

  factory API() {
    return _api;
  }

  API._internal();

  late Dio dio;
  late RestClient client;

  Future initDio() async {
    dio = Dio();

    dio.options.baseUrl = Constants.host;

    dio.options.connectTimeout = Constants.timeoutInMillis;
    dio.options.sendTimeout = Constants.timeoutInMillis;
    dio.options.receiveTimeout = Constants.timeoutInMillis;
    dio.options.contentType = Headers.contentTypeHeader;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print(e);
          return handler.next(e);
        },
      ),
    );

    client = RestClient(dio, baseUrl: dio.options.baseUrl);
  }
}
