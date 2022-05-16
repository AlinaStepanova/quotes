import 'package:connectivity_plus_platform_interface/src/enums.dart';

import '../api/api.dart';
import '../api/rest_client.dart';
import 'local_data_service.dart';

class QuotesRepository {
  static late QuotesRepository _quotesService;
  late RestClient apiClient;
  late LocalDataService localDataClient;

  factory QuotesRepository([RestClient? client, LocalDataService? localData]) {
    _quotesService = QuotesRepository._internal(client, localData);
    return _quotesService;
  }

  QuotesRepository._internal([client, localData]) {
    apiClient = client ?? API().client;
    localDataClient = localData ?? LocalDataService();
  }

  Future<Quote?> getQuote([ConnectivityResult? connectionStatus]) async {
    Quote? quote = null;
    if (connectionStatus == ConnectivityResult.none) {
      quote = await localDataClient.getLocalQuote();
    } else {
      try {
        quote = await apiClient.getRandomQuote();
      } catch (e) {
        quote = await localDataClient.getLocalQuote();
      }
    }
    return quote;
  }
}
