import 'package:connectivity_plus_platform_interface/src/enums.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/rest_client.dart';
import 'local_data_service.dart';

class QuotesRepository with ChangeNotifier {
  static final QuotesRepository _quotesService = QuotesRepository._internal();
  QuotesRepository._internal();
  factory QuotesRepository() {
    return _quotesService;
  }

  final _api = API();
  final _localData = LocalDataService();

  Quote? _quote = null;
  Quote? get quote => _quote;

  Future<void> getQuote([ConnectivityResult? connectionStatus]) async {
    if (connectionStatus == ConnectivityResult.none) {
      _quote = await _localData.getLocalQuote();
    } else {
      try {
        _quote = await _api.client.getRandomQuote();
      } catch (e) {
        _quote = await _localData.getLocalQuote();
      }
    }

    notifyListeners();
  }

  void resetSate() {
    _quote = null;
    notifyListeners();
  }

  @visibleForTesting
  Future<Quote?> provideQuote(
      RestClient client, LocalDataService localData) async {
    Quote? quote = null;
    try {
      quote = await client.getRandomQuote();
    } catch (e) {
      quote = await localData.getLocalQuote();
    }

    return quote;
  }
}
