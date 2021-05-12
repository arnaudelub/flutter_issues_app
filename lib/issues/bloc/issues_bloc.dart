import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:pedantic/pedantic.dart';

part 'issues_event.dart';
part 'issues_state.dart';

part 'issues_bloc.freezed.dart';

@injectable
class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc(this._repository) : super(const IssuesState.initial());
  final IGithubApiRepository _repository;

  StreamSubscription<List<Issue?>>? issuesStreamSubscription;
  @override
  Stream<IssuesState> mapEventToState(
    IssuesEvent event,
  ) async* {
    yield* event.map(watchIssuesAsked: (WatchIssuesAsked _) async* {
      yield const IssuesState.isLoading();
      unawaited(_repository.watchPaginatedIssues());
      await issuesStreamSubscription?.cancel();
      issuesStreamSubscription = _repository.repoStream
          .listen((data) => add(IssuesEvent.issuesReceived(data)));
    }, issuesReceived: (IssuesReceived data) async* {
      yield IssuesState.issuesSuccess(data.issue);
    });
  }
}
