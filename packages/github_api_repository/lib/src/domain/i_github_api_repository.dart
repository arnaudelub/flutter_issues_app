import 'package:github_api_repository/src/domain/domain.dart'
    show Issue, Issues;

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  String? issueStateFilter;
  Stream<Issue> get repoStream;
  Future<void> close();
  Future<void> getIssueDetails(int issueNumber);
  void setStateFilterFromString(String filter);
  Future<Issues> watchPaginatedIssues({String? after});
}

class QueryError extends Error {}
