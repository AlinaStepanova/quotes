import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: "http://quotes.stormconsultancy.co.uk")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/random.json")
  Future<Quote> getRandomQuote();
}

@JsonSerializable()
class Quote {
  int id;
  String author;
  String quote;
  String permalink;

  Quote(
      {required this.id,
      required this.author,
      required this.quote,
      required this.permalink});

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

