import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:quotes_app/api/rest_client.dart';

class LocalDataService {
  static final LocalDataService _quotesService = LocalDataService._internal();
  LocalDataService._internal();
  factory LocalDataService() {
    return _quotesService;
  }

  List<Quote>? _localQuotes = null;

  Future<List<Quote>> _readQuotesFromJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

    return parsed.map<Quote>((json) => Quote.fromJson(json)).toList();
  }

  Quote _getRandomQuote(List<Quote> quotes) {
    final _random = new Random();
    var quote = quotes[_random.nextInt(quotes.length)];
    return quote;
  }

  Future<Quote> getLocalQuote() async {
    if (_localQuotes == null) {
      _localQuotes = await _readQuotesFromJson();
    }
    var quote = _getRandomQuote(_localQuotes ?? []);
    return quote;
  }
}
