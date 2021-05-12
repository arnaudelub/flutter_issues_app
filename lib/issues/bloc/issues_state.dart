part of 'issues_bloc.dart';

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState.initial() = Initial;
  const factory IssuesState.isLoading() = IsLoading;
  const factory IssuesState.issuesSuccess(List<Issue?> issues) = IssuesSuccess;
}
