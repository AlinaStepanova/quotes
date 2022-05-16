import 'package:hive_flutter/hive_flutter.dart';

import 'quote_model.dart';

class HiveService {
  static final HiveService _hiveService = HiveService._internal();
  HiveService._internal();
  factory HiveService() {
    return _hiveService;
  }

  final String _quotesBox = 'quotes';

  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox<QuoteModel>(_quotesBox);
  }

  Future<void> addQuote(QuoteModel quote) async {
    await Hive.box(_quotesBox).add(quote);
  }
}
