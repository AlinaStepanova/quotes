import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:quotes_app/api/rest_client.dart';

class QuotesService {
  static final QuotesService _quotesService = QuotesService._internal();
  QuotesService._internal();
  factory QuotesService() {
    return _quotesService;
  }

  List<Quote>? _localQuotes = null;

  Future<List<Quote>> _readQuotesFromJson() async {
    print("1");
    final String response = await rootBundle.loadString('assets/quotes.json');
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

    return parsed.map<Quote>((json) => Quote.fromJson(json)).toList();
  }

  Future<Quote> _getRandomQuote(List<Quote> quotes) async {
    print("2");
    final _random = new Random();
    var quote = quotes[_random.nextInt(quotes.length)];
    return quote;
  }

  Future<Quote> getQuote() async {
    print("3");
    if (_localQuotes == null) {
      _localQuotes = await _readQuotesFromJson();
    }
    var quote = _getRandomQuote(_localQuotes ?? []);
    return quote;
  }
}
