part of 'issues_bloc.dart';

@freezed
class IssuesEvent with _$IssuesEvent {
  const factory IssuesEvent.watchIssuesAsked() = WatchIssuesAsked;
  const factory IssuesEvent.issuesReceived(List<Issue?> issue) = IssuesReceived;
}
