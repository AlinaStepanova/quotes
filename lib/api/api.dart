import 'dart:async';
import 'package:dio/dio.dart';
import 'rest_client.dart';

String host = "http://quotes.stormconsultancy.co.uk/";

class API {
  static final API _api = API._internal();

  factory API() {
    return _api;
  }

  API._internal();

  late Dio dio;
  late RestClient client;
  late StreamController _errorListener;
  Stream get fetchErrors => _errorListener.stream;

  Future initDio() async {
    _errorListener = new StreamController.broadcast();
    dio = Dio(); // Provide a dio instance

    dio.options.baseUrl = host;

    dio.options.connectTimeout = 5000;
    dio.options.sendTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.contentType = Headers.contentTypeHeader;

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); 
    }, onResponse: (response, handler) {
      if (response.statusCode == 500) {
        return null;
      }
      return handler.next(response); 
    }, onError: (DioError e, handler) {
      print(e);
      _errorListener.add(e);
      return handler.next(e); 
    }));

    client = RestClient(dio, baseUrl: dio.options.baseUrl);
  }
}
