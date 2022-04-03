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

  final dioError = DioError(
    response: Response(
        data: 'Something went wrong',
        statusCode: 404,
        requestOptions: RequestOptions(path: Constants.host)),
    requestOptions: RequestOptions(path: Constants.host),
  );

  final List<Quote> quotes = [
    Quote(id: 1, author: "author 1", quote: "quote 1"),
    Quote(id: 2, author: "author 2", quote: "quote 2"),
    Quote(id: 3, author: "author 3", quote: "quote 3")
  ];

  setUp(() async {
    client = MockRestClient();
    localStorage = MockLocalDataService();
    dataSource = QuoteRemoteDataSourceImpl(client: client);
  });

  group('test fetching a quote from api and local storage', () {
    test('returns an Quote if the http call completes successfully', () async {
      when(client.getRandomQuote()).thenAnswer((_) async => quotes[0]);

      expect(await client.getRandomQuote(), isA<Quote>());
    });

    test('test an error if the http call fails', () async {
      when(client.getRandomQuote()).thenThrow(dioError);
      final call = dataSource.getRandomQuote;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });

    test('test local storage is not triggered if API call is succesfull',
        () async {
      when(client.getRandomQuote()).thenAnswer((_) async => quotes[0]);

      expect(await repository.provideQuote(client, localStorage), isA<Quote>());
      verify(client.getRandomQuote()).called(1);
      verifyNever(localStorage.getLocalQuote());
    });

    test('test local storage is triggered when API call failes', () async {
      when(client.getRandomQuote()).thenThrow(dioError);
      when(localStorage.getLocalQuote()).thenAnswer((_) async => quotes[0]);

      expect(await repository.provideQuote(client, localStorage), isA<Quote>());
      verify(client.getRandomQuote()).called(1);
      verify(localStorage.getLocalQuote()).called(1);
    });

    test('test random local quote with valid data', () async {
      when(localStorage.getRandomQuote(quotes)).thenReturn(quotes[0]);
      expect(localStorage.getRandomQuote(quotes), isA<Quote>());
    });

    test('test random local quote with empty list', () async {
      when(localStorage.getRandomQuote([])).thenReturn(null);
      expect(localStorage.getRandomQuote([]), isNull);
    });
  });
}
