import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_repository/src/domain/domain.dart';
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

  setUpAll(() {
    _mockHiveRepository = MockHiveRepository();
    _mockGraphQlClient = MockGraphQlClient();
    _repository = GithubApiRepository(_mockGraphQlClient, _mockHiveRepository);
    registerFallbackValue(MockQueryOption());
  });

  void mockClientReturnError() {
    when(() => _mockGraphQlClient.query(any())).thenAnswer((invocation) async =>
        QueryResult(
            data: (json.decode(fixture('error.json'))
                as Map<String, dynamic>)['data'],
            exception: OperationException(),
            source: QueryResultSource.network));
  }

  void mockQueryResultWithFixture(String jsonFile) {
    when(() => _mockGraphQlClient.query(any())).thenAnswer((invocation) async =>
        QueryResult(
            data: (json.decode(fixture(jsonFile))
                as Map<String, dynamic>)['data'],
            source: QueryResultSource.network));
  }

  group('Set State filter from String', () {
    const filterOpen = 'open';
    const filterClose = 'closed';
    test('_issueStateFilter should be OPEN when filter is open', () {
      _repository.setStateFilterFromString(filterOpen);
      expect(_repository.issueStateFilter, openState);
    });
    test('_issueStateFilter should be CLOSED when filter is closed', () {
      _repository.setStateFilterFromString(filterClose);
      expect(_repository.issueStateFilter, closeState);
    });
  });

  group('WatchPaginatedIssues', () {
    Future<Issues> myAsyncFunction() async {
      final result = await _repository.watchPaginatedIssues();

      return result;
    }

    test('Should throw Exception When client return hasException', () async {
      mockClientReturnError();
      expect(myAsyncFunction(), throwsA(isA<QueryError>()));
    });

    test('Should be of type Issues when no error', () async {
      mockQueryResultWithFixture('issues.json');
      when(() => _mockHiveRepository.isCachedAndUpdate(any(), any()))
          .thenReturn(false);
      final result = await myAsyncFunction();
      expect(result, isA<Issues>());
    });
  });

  group('getIssueDetails', () {
    final numberTest = 82567;
    Future<void> myAsyncFunction() async {
      await _repository.getIssueDetails(numberTest);
    }

    test('Should throw Exception When client return hasException', () async {
      mockClientReturnError();
      expect(myAsyncFunction(), throwsA(isA<QueryError>()));
    });

    test('Should be of type Issues when no error', () async {
      mockQueryResultWithFixture('issue.json');

      when(() => _mockHiveRepository.isCachedAndUpdate(any(), any()))
          .thenReturn(false);
      _repository.repoStream.listen(
        expectAsync1(
          (event) {
            expect(event, isA<Issue>());
          },
        ),
      );
      await myAsyncFunction();
    });
  });
}
