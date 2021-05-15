import 'package:flutter/widgets.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:github_api_repository/src/domain/domain.dart'
    show Edge, IGithubApiRepository, Issue, defaultPaginatedIssues;
import 'package:github_api_repository/src/infrastructure/infrastructure.dart'
    show GqlDataDto;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/rxdart.dart';

const openState = 'OPEN';
const closeState = 'CLOSED';

const availableFilterState = [
  'open',
  'closed',
];

class GithubApiRepository implements IGithubApiRepository {
  GithubApiRepository(this.client);

  final GraphQLClient client;

  final BehaviorSubject<Issue> _repoSubject = BehaviorSubject<Issue>();

  String _issueStateFilter = openState;

  @override
  void setIsOpenStateFilter() => _issueStateFilter = openState;

  @override
  void setIsClosedStateFilter() => _issueStateFilter = closeState;

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
  Stream<Issue> get repoStream => _repoSubject.stream;

  @override
  List<Edge?> getEdgesFromResponse(Map<String, dynamic> response) {
    final data = GqlDataDto.fromJson(response['repository']).toDomain();
    return data.issues!.edges;
  }

  @override
  Issue getIssueFromResponse(Map<String, dynamic> response) {
    final data = GqlDataDto.fromJson(response['repository']).toDomain();
    if (data.issue == null) {
      throw Exception('Value is null');
    }
    return data.issue!;
  }

  @override
  Future<List<Edge?>> watchPaginatedIssues({String? after}) async {
    final _option = QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(_getPaginatedIssue(after)),
      variables: <String, dynamic>{
        'nIssues': defaultPaginatedIssues,
        'states': _issueStateFilter,
      },
      pollInterval: const Duration(seconds: 4),
    );
    final result = await client.query(_option);

    if (result.hasException) {
      print(result.exception!);
      throw Exception();
    }

    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final issues = getEdgesFromResponse(result.data!);
    return issues;
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
      _repoSubject.addError(result.exception!);
      throw UnimplementedError();
    }
    // result.data can be either a [List<dynamic>] or a [Map<String, dynamic>]
    final issue = getIssueFromResponse(result.data!);
    _repoSubject.add(issue);
  }

  @override
  Future<void> close() async {
    await _repoSubject.close();
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
      edges {
        cursor
        node {
          id
          author {
            login
          }
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
      author {
        login
      }
      labels(last: 50, orderBy: {field: CREATED_AT, direction: DESC}) {
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
      comments(last: 50, orderBy: {field: UPDATED_AT, direction: DESC}) {
        edges {
          cursor
          node {
            id
            author {
              login
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
}
