import 'package:github_api_repository/src/domain/domain.dart'
    show Issue, Issues;
import 'package:github_api_repository/src/filter/filter.dart';

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  bool? isSortedDesc;
  String? issueStateFilter;
  Stream<Issue> get repoStream;
  Future<void> close();
  Future<void> getIssueDetails(int issueNumber);
  void setFilter(Filter filter);
  Future<Issues> watchPaginatedIssues({String? after});
}

class QueryError extends Error {}
