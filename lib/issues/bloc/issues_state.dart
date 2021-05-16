part of 'issues_bloc.dart';

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState({
    required bool isLoading,
    required bool moreIsLoading,
    Issues? issues,
  }) = _IssueState;

  factory IssuesState.initial() => const IssuesState(
        isLoading: false,
        moreIsLoading: false,
      );
}
