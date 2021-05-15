part of 'issues_bloc.dart';

@freezed
class IssuesEvent with _$IssuesEvent {
  const factory IssuesEvent.fetchIssuesAsked() = FetchIssuesAsked;
  const factory IssuesEvent.setFiltersAsked(Filter filter) = SetFiltersAsked;
}
