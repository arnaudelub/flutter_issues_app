import 'dart:async';

import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/issues/bloc/filter_form_bloc/filter_form_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';

part 'issues_event.dart';
part 'issues_state.dart';

part 'issues_bloc.freezed.dart';

@injectable
class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc(
    this._repository,
  ) : super(const IssuesState.initialIssues());
  final IGithubApiRepository _repository;

  StreamSubscription<List<Edge?>>? _issuesStreamSubscription;
  @override
  Stream<IssuesState> mapEventToState(
    IssuesEvent event,
  ) async* {
    yield* event.map(fetchIssuesAsked: (FetchIssuesAsked data) async* {
      yield const IssuesState.isLoading();
      final issues = await _repository.watchPaginatedIssues();
      yield IssuesState.issuesSuccess(issues);
    }, setFiltersAsked: (SetFiltersAsked data) async* {
      final filter = data.filter;
      if (filter.states != null) {
        _repository.setStateFilterFromString(filter.states!);
        add(const IssuesEvent.fetchIssuesAsked());
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    await _issuesStreamSubscription?.cancel();
    await _repository.close();
  }
}
