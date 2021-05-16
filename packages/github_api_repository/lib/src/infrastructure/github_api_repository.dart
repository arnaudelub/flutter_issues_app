import 'package:flutter/widgets.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:github_api_repository/src/domain/domain.dart'
    show Edge, IGithubApiRepository, Issue, defaultPaginatedIssues, QueryError;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show GqlDataDto;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:rxdart/rxdart.dart';

const availableFilterState = [
  'open',
  'closed',
];
const closeState = 'CLOSED';

const openState = 'OPEN';

class GithubApiRepository implements IGithubApiRepository {
  GithubApiRepository(this.client, this._hiveRepository);

  final GraphQLClient client;

  final IHiveRepository _hiveRepository;

  final BehaviorSubject<Issue> _repoSubject = BehaviorSubject<Issue>();
  @override
  String? issueStateFilter = openState;

  @override
  Stream<Issue> get repoStream => _repoSubject.stream;

  @override
  Future<void> close() async {
    await _repoSubject.close();
  }

  Issues getEdgesFromResponse(Map<String, dynamic> response) {
    final data = GqlDataDto.fromJson(response['repository']).toDomain();
    //ignore: omit_local_variable_types
    final List<Edge> edges = [];
    for (final issue in data.issues!.edges) {
      final edge = issue!.copyWith(
          node: issue.node.copyWith(
              isCached: _hiveRepository.isCachedAndUpdate(
                  issue.node.id, issue.node.updatedAt)));
      edges.add(edge);
    }
    return data.issues!.copyWith(edges: edges);
  }

  @override
  Future<void> getIssueDetails(int issueNumber) async {
    final _option = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(_getIssuesDetailsQuery()),
      variables: <String, dynamic>{
        'nNumber': issueNumber,
      },
      pollInterval: const Duration(seconds: 4),
      fetchResults: false,
    );
    final result = await client.query(_option);
    if (result.hasException) {
      debugPrint(result.toString());
      //_repoSubject.addError(result.exception!);
      throw QueryError();
    }
    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final issue = getIssueFromResponse(result.data!);
    _repoSubject.add(issue);
  }

  Issue getIssueFromResponse(Map<String, dynamic> response) {
    final data = GqlDataDto.fromJson(response['repository']).toDomain();
    if (data.issue == null) {
      throw Exception('Value is null');
    }
    return data.issue!;
  }

  void setIsClosedStateFilter() => issueStateFilter = closeState;

  void setIsOpenStateFilter() => issueStateFilter = openState;

  @override
  void setStateFilterFromString(String filter) {
    if (!availableFilterState.contains(filter)) {
      throw Exception('Invalid filter');
    }
    if (filter == availableFilterState[0]) {
      setIsOpenStateFilter();
    } else {
      setIsClosedStateFilter();
    }
  }

  @override
  Future<Issues> watchPaginatedIssues({String? after}) async {
    final _option = QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(_getPaginatedIssue(after)),
      variables: <String, dynamic>{
        'nIssues': defaultPaginatedIssues,
        'states': issueStateFilter,
      },
      pollInterval: const Duration(seconds: 4),
    );
    final result = await client.query(_option);

    if (result.hasException) {
      throw QueryError();
    }

    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final issues = getEdgesFromResponse(result.data!);
    return issues;
  }

  String _getIssuesDetailsQuery() {
    return '''
query issueDetails(\$nNumber: Int!){
  repository(name: "flutter", owner: "flutter") {
    name
    issue(number: \$nNumber) {
      id
      number
      title
      state
      bodyText
      author {
        login
      }
      labels(last: 50, orderBy: {field: CREATED_AT, direction: DESC}) {
        totalCount
        edges {
          cursor
          node {
            id
            createdAt
            updatedAt
            name
          }
        }
      }
      comments(last: 100, orderBy: {field: UPDATED_AT, direction: DESC}) {
        totalCount
        edges {
          cursor
          node {
            id
            author {
              login
              avatarUrl
            }
            createdAt
            updatedAt
            bodyText
          }
        }
      }
      createdAt
      updatedAt
      closedAt
    }
  }
}
        ''';
  }

  String _getPaginatedIssue(String? after) {
    var query = '''
query readIssues(\$nIssues: Int!, \$states: [IssueState!]) {
  repository(name: \"flutter\", owner: \"flutter\") {
    name
      issues(
        first: \$nIssues, 
        states: \$states, 
        ''';
    if (after != null) {
      query += 'after:"$after"';
    }
    query += '''
        orderBy: {
          field: CREATED_AT
          direction: DESC
        }) {
      totalCount
      edges {
        cursor
        node {
          id
          author {
            login
            avatarUrl
          }
          bodyText
          number
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
}
