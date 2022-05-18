import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'quote_model.dart';

class HiveService {
  static final HiveService _hiveService = HiveService._internal();

  factory HiveService() {
    return _hiveService;
  }

  HiveService._internal();

  final String _quotesBox = 'quotes';
  late Box<QuoteModel> box;

  Future<void> initHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter<QuoteModel>(QuoteModelAdapter());
    box = await Hive.openBox<QuoteModel>(_quotesBox);
  }

  Future<void> addQuote(QuoteModel quote) async {
    await box.put(quote.id, quote);
  }

  QuoteModel getQuoteById(int quoteId) {
    QuoteModel filteredQuote = box.values.firstWhere(
        (quote) => quote.id == quoteId,
        orElse: () => QuoteModel.empty());
    return filteredQuote;
  }
}
