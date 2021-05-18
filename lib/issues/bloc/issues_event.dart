part of 'issues_bloc.dart';

@freezed
class IssuesEvent with _$IssuesEvent {
  const factory IssuesEvent.fetchIssuesAsked() = FetchIssuesAsked;
  const factory IssuesEvent.setFiltersAsked(Filter filter) = SetFiltersAsked;
  const factory IssuesEvent.fetchMoreAsked(String after) = FetchMoreAsked;
  const factory IssuesEvent.toggleOrderAsked() = ToggleOrderAsked;
}
