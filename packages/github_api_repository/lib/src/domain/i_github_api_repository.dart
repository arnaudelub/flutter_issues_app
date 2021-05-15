import 'package:github_api_repository/src/domain/domain.dart' show Edge, Issue;

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  void setIsOpenStateFilter();
  void setIsClosedStateFilter();
  void setStateFilterFromString(String filter);
  List<Edge?> getEdgesFromResponse(Map<String, dynamic> response);
  Future<List<Edge?>> watchPaginatedIssues({String? after});
  Stream<Issue> get repoStream;
  Future<void> close();
  Future<void> getIssueDetails(int issueNumber);
  Issue getIssueFromResponse(Map<String, dynamic> response);
}
