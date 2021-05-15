part of 'issues_bloc.dart';

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState.initialIssues() = InitialIssues;
  const factory IssuesState.isLoading() = IsLoading;
  const factory IssuesState.issuesSuccess(Issues issues) = IssuesSuccess;
}
