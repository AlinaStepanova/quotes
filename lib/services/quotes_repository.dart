import 'package:connectivity_plus_platform_interface/src/enums.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/rest_client.dart';
import 'local_data_service.dart';

class QuotesRepository with ChangeNotifier {
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

  Quote? _quote = null;
  Quote? get quote => _quote;

  Future<Quote?> getQuote([ConnectivityResult? connectionStatus]) async {
    if (connectionStatus == ConnectivityResult.none) {
      _quote = await localDataClient.getLocalQuote();
    } else {
      try {
        _quote = await apiClient.getRandomQuote();
      } catch (e) {
        _quote = await localDataClient.getLocalQuote();
      }
    }

    notifyListeners();
    return quote;
  }

  void resetSate() {
    _quote = null;
    notifyListeners();
  }
}
