import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quotes/api/rest_client.dart';
import 'package:quotes/services/local_data_service.dart';
import 'package:quotes/services/quotes_repository.dart';
import 'package:quotes/utils/constants.dart';
import 'package:quotes/utils/test_utils.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([RestClient, LocalDataService])
Future<void> main() async {
  final QuotesRepository repository = QuotesRepository();
  late MockRestClient client;
  late MockLocalDataService localStorage;
  late QuoteRemoteDataSourceImpl dataSource;

  setUp(() async {
    client = MockRestClient();
    localStorage = MockLocalDataService();
    dataSource = QuoteRemoteDataSourceImpl(client: client);
  });

  group('fetch a quote from api and local storage', () {
    test('returns an Quote if the http call completes successfully', () async {
      when(client.getRandomQuote()).thenAnswer(
          (_) async => Quote(id: 1, author: "author", quote: "quote"));

      expect(await client.getRandomQuote(), isA<Quote>());
    });

    test('returns an error if the http call fails', () async {
      when(client.getRandomQuote()).thenThrow(DioError(
        response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: Constants.host)),
        requestOptions: RequestOptions(path: Constants.host),
      ));

      final call = dataSource.getRandomQuote;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });

    test('test local storage is not triggered if API call is succesfull',
        () async {
      when(client.getRandomQuote()).thenAnswer(
          (_) async => Quote(id: 1, author: "author", quote: "quote"));

      expect(await repository.provideQuote(client, localStorage), isA<Quote>());
      verify(client.getRandomQuote()).called(1);
      verifyNever(localStorage.getLocalQuote());
    });
  });
}
