import 'package:dio/dio.dart';
import 'package:quotes/api/rest_client.dart';

class ServerException implements Exception {}

abstract class QuoteRemoteDataSource {
  Future<Quote> getRandomQuote();
}

//The porpuse of this class is to provide a custom error
//in order to test the scenario when API request failer
class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  QuoteRemoteDataSourceImpl({
    required this.client,
  });

  RestClient client;

  @override
  Future<Quote> getRandomQuote() async {
    try {
      return await client.getRandomQuote();
    } on DioError catch (_) {
      throw ServerException();
    }
  }
}
