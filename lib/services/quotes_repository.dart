import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/rest_client.dart';
import 'local_data_service.dart';

class QuotesRepository {
  static final QuotesRepository _quotesService = QuotesRepository._internal();
  QuotesRepository._internal();
  factory QuotesRepository() {
    return _quotesService;
  }

  final _api = API();
  final _localData = LocalDataService();

  Future<Quote?> getQuote() async {
    Quote? quote = null;
    try {
      quote = await _api.client.getRandomQuote();
    } catch (e) {
      quote = await _localData.getLocalQuote();
    }

    return quote;
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
