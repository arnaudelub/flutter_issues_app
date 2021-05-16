import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'issues_bloc.freezed.dart';
part 'issues_event.dart';
part 'issues_state.dart';

@injectable
class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc(
    this._repository,
  ) : super(IssuesState.initial());
  final IGithubApiRepository _repository;

  StreamSubscription<List<Edge?>>? _issuesStreamSubscription;
  @override
  Stream<IssuesState> mapEventToState(
    IssuesEvent event,
  ) async* {
    yield* event.map(fetchIssuesAsked: (FetchIssuesAsked data) async* {
      yield state.copyWith(
        isLoading: true,
      );
      final issuesQuery = await _repository.watchPaginatedIssues();
      yield state.copyWith(isLoading: false, issues: issuesQuery);
    }, setFiltersAsked: (SetFiltersAsked data) async* {
      final filter = data.filter;
      if (filter.states != null) {
        _repository.setStateFilterFromString(filter.states!);
        add(const IssuesEvent.fetchIssuesAsked());
      }
    }, fetchMoreAsked: (FetchMoreAsked data) async* {
      yield state.copyWith(
        moreIsLoading: true,
      );
      final issuesQuery =
          await _repository.watchPaginatedIssues(after: data.after);
      yield state.copyWith(
        moreIsLoading: false,
        issues: state.issues!
            .copyWith(edges: [...state.issues!.edges, ...issuesQuery.edges]),
      );
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    await _issuesStreamSubscription?.cancel();
    await _repository.close();
  }
}
