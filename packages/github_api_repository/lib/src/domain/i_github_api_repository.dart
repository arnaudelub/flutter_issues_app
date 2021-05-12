import 'package:github_api_repository/src/domain/issue.dart';

const int defaultPaginatedIssues = 50;

abstract class IGithubApiRepository {
  String getPaginatedIssue();
  List<Issue?> getEdgesFromResponse(Map<String, dynamic> response);
  Future<void> watchPaginatedIssues();
  Stream<List<Issue?>> get repoStream;
  Future<void> close();
}
