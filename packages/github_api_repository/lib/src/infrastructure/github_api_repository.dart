import 'package:github_api_repository/github_api_repository.dart';
import 'package:github_api_repository/src/domain/issue.dart';
import 'package:github_api_repository/src/infrastructure/issue_dto.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';

class GithubApiRepository implements IGithubApiRepository {
  GithubApiRepository(this.client);

  final GraphQLClient client;

  final BehaviorSubject<List<Issue?>> _repoSubject =
      BehaviorSubject<List<Issue?>>();
  @override
  Stream<List<Issue?>> get repoStream => _repoSubject.stream;

  @override
  String getPaginatedIssue() {
    final query = '''
query readIssues(\$nIssues: Int!) {
  repository(name: \"flutter\", owner: \"flutter\") {
    name
    issues(last: \$nIssues, states: [CLOSED, OPEN]) {
      edges {
        node {
          id
          author {
            login
          }
          title
          state
          createdAt
          updatedAt
          closedAt
        }
      }
    }
  }
}
    ''';
    return query;
  }

  @override
  List<Issue?> getEdgesFromResponse(Map<String, dynamic> response) {
    final repository = IssuesDto.fromJson(response['repository']);
    return repository.edges.issues;
  }

  @override
  Future<void> watchPaginatedIssues() async {
    final _option = WatchQueryOptions(
      document: gql(getPaginatedIssue()),
      variables: <String, dynamic>{
        'nIssues': defaultPaginatedIssues,
      },
      pollInterval: const Duration(seconds: 4),
      fetchResults: true,
    );
    final result = await client.query(_option);

    if (result.hasException) {
      _repoSubject.addError(result.exception!);
      return;
    }

    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final issues = getEdgesFromResponse(result.data!);

    _repoSubject.add(issues);
  }

  @override
  Future<void> close() async {
    await _repoSubject.close();
  }
}
