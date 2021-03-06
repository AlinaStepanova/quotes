import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/api/rest_client.dart';

class LocalDataService {
  static final LocalDataService _quotesService = LocalDataService._internal();
  LocalDataService._internal();
  factory LocalDataService() {
    return _quotesService;
  }

  List<Quote>? _localQuotes = null;

  @visibleForTesting
  Future<List<Quote>> readQuotesFromJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

    return parsed.map<Quote>((json) => Quote.fromJson(json)).toList();
  }

  @visibleForTesting
  Quote? getRandomQuote(List<Quote> quotes) {
    if (quotes.isEmpty) return null;
    final _random = new Random();
    var quote = quotes[_random.nextInt(quotes.length)];
    return quote;
  }

  Future<Quote?> getLocalQuote() async {
    if (_localQuotes == null) {
      _localQuotes = await readQuotesFromJson();
    }
    var quote = getRandomQuote(_localQuotes ?? []);
    return quote;
  }
}
