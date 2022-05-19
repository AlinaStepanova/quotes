import 'package:connectivity_plus_platform_interface/src/enums.dart';

import '../api/api.dart';
import '../api/rest_client.dart';
import '../db/db_service.dart';
import '../db/quote_model.dart';
import 'local_data_service.dart';

class QuotesRepository {
  static late QuotesRepository _quotesService;
  late RestClient apiClient;
  late LocalDataService localDataClient;
  late HiveService hiveService;

  factory QuotesRepository(
      [RestClient? client, LocalDataService? localData, HiveService? hive]) {
    _quotesService = QuotesRepository._internal(client, localData, hive);
    return _quotesService;
  }

  QuotesRepository._internal([client, localData, hive]) {
    apiClient = client ?? API().client;
    localDataClient = localData ?? LocalDataService();
    hiveService = hive ?? HiveService();
  }

  Future<QuoteModel?> getQuote([ConnectivityResult? connectionStatus]) async {
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
    if (quote != null) {
      var fetchedQuote = QuoteModel.from(quote);
      var localQuote = await hiveService.getQuote(fetchedQuote);
      fetchedQuote.isFavorite = localQuote?.isFavorite ?? false;
      return fetchedQuote;
    } else {
      return null;
    }
  }

  Future<QuoteModel> setFavorite(QuoteModel quoteModel) async {
    var localQuote = await hiveService.getQuote(quoteModel);
    if (localQuote != null) {
      quoteModel.isFavorite = false;
      await hiveService.removeQuote(quoteModel);
    } else {
      quoteModel.isFavorite = true;
      await hiveService.addQuote(quoteModel);
    }
    return quoteModel;
  }

  Future<void> initHive() async {
    await hiveService.initHive();
  }
}
