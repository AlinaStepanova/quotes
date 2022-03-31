import 'package:hive/hive.dart';

import '../api/rest_client.dart';

@HiveType(typeId: 0)
class QuoteModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String author;

  @HiveField(2)
  String quote;

  @HiveField(3)
  bool isFavorite;

  QuoteModel({
    required this.id,
    required this.author,
    required this.quote,
    this.isFavorite = false,
  });

  factory QuoteModel.from(Quote quoteFromServer) {
    return QuoteModel(
        id: quoteFromServer.id,
        author: quoteFromServer.author,
        quote: quoteFromServer.quote);
  }
}
