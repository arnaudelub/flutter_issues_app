import 'package:github_api_repository/src/domain/domain.dart'
    show Issue, Issues;
import 'package:github_api_repository/src/filter/filter.dart';

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  /// Property which define the orderBy clause __DESC or AS__
  bool? isSortedDesc;

  /// Property to set the state as __CLOSED__ or __OPEN__
  String? issueStateFilter;

  /// Stream to listen to the issue details
  /// ```dart
  /// repoStream.listen((onData) => //Do stuff);
  ///
  Stream<Issue> get repoStream;

  /// Use it to close [BehaviorSubject<Issue>]
  /// and avoid memory leak
  Future<void> close();

  /// Call this method before so you can listen
  /// to repoStream
  Future<void> getIssueDetails(int issueNumber);

  /// Method to set the filters
  /// Currently allowed: __states__ and __author__
  void setFilter(Filter filter);

  /// Use this method to get the first 50 issues
  /// orderBy __DESC__ on __CREATED_AT__ by default
  Future<Issues> watchPaginatedIssues({String? after});
}

class QueryError extends Error {}
