part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.watchIssueDetailsAsked(int number) =
      WatchIssueDetailsAsked;
  const factory DetailsEvent.issueDetailsReceived(Issue issue) =
      IssueDetailsReceived;
}
