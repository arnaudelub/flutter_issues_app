import 'package:github_api_repository/src/domain/domain.dart'
    show Edge, Issue, Issues;

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  void setIsOpenStateFilter();
  void setIsClosedStateFilter();
  void setStateFilterFromString(String filter);
  Issues getEdgesFromResponse(Map<String, dynamic> response);
  Future<Issues> watchPaginatedIssues({String? after});
  Stream<Issue> get repoStream;
  Future<void> close();
  Future<void> getIssueDetails(int issueNumber);
  Issue getIssueFromResponse(Map<String, dynamic> response);
}
