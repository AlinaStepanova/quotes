import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/constants.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.host)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("random.json")
  Future<Quote> getRandomQuote();
}

@JsonSerializable()
class Quote {
  int id;
  String author;
  String quote;

  Quote({
    required this.id,
    required this.author,
    required this.quote,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
