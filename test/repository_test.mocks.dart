// Mocks generated by Mockito 5.1.0 from annotations
// in quotes/test/repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:quotes/api/rest_client.dart' as _i2;
import 'package:quotes/services/local_data_service.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeQuote_0 extends _i1.Fake implements _i2.Quote {}

/// A class which mocks [RestClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestClient extends _i1.Mock implements _i2.RestClient {
  MockRestClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.Quote> getRandomQuote() =>
      (super.noSuchMethod(Invocation.method(#getRandomQuote, []),
              returnValue: Future<_i2.Quote>.value(_FakeQuote_0()))
          as _i3.Future<_i2.Quote>);
}

/// A class which mocks [LocalDataService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataService extends _i1.Mock implements _i4.LocalDataService {
  MockLocalDataService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i2.Quote>> readQuotesFromJson() =>
      (super.noSuchMethod(Invocation.method(#readQuotesFromJson, []),
              returnValue: Future<List<_i2.Quote>>.value(<_i2.Quote>[]))
          as _i3.Future<List<_i2.Quote>>);
  @override
  _i2.Quote? getRandomQuote(List<_i2.Quote>? quotes) =>
      (super.noSuchMethod(Invocation.method(#getRandomQuote, [quotes]))
          as _i2.Quote?);
  @override
  _i3.Future<_i2.Quote?> getLocalQuote() =>
      (super.noSuchMethod(Invocation.method(#getLocalQuote, []),
          returnValue: Future<_i2.Quote?>.value()) as _i3.Future<_i2.Quote?>);
}
