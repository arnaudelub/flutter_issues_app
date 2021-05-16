import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_repository/src/domain/i_github_api_repository.dart';
import 'package:github_api_repository/src/domain/issues/issues.dart';
import 'package:github_api_repository/src/infrastructure/github_api_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'fixtures/fixture_reader.dart';

class MockGraphQlClient extends Mock implements GraphQLClient {}

class MockHiveRepository extends Mock implements IHiveRepository {}

class MockQueryOption extends Mock implements QueryOptions {}

class MockQueryResult extends Mock implements QueryResult {}

void main() {
  late IGithubApiRepository _repository;
  late MockGraphQlClient _mockGraphQlClient;
  late MockHiveRepository _mockHiveRepository;
  late MockQueryResult _mockQueryResult;

  setUpAll(() {
    _mockHiveRepository = MockHiveRepository();
    _mockGraphQlClient = MockGraphQlClient();
    _repository = GithubApiRepository(_mockGraphQlClient, _mockHiveRepository);
    _mockQueryResult = MockQueryResult();
    registerFallbackValue(MockQueryOption());
  });

  Future<Issues> myAsyncFunction() async {
    final result = await _repository.watchPaginatedIssues();

    return result;
  }

  group('WatchPaginatedIssues', () {
    test('Should throw Exception When client return hasException', () async {
      when(() => _mockGraphQlClient.query(any())).thenAnswer(
          (invocation) async => QueryResult(
              data: json.decode(fixture('issues.json'))['data'],
              exception: OperationException(),
              source: QueryResultSource.network));
      expect(myAsyncFunction(), throwsA(isA<QueryError>()));
    });
  });
}
