import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';

part 'details_event.dart';
part 'details_state.dart';

part 'details_bloc.freezed.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(this._repository) : super(const DetailsState.initial());
  final IGithubApiRepository _repository;

  StreamSubscription<Issue>? _issueStreamSubscription;
  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    yield* event.map(
        watchIssueDetailsAsked: (WatchIssueDetailsAsked data) async* {
      yield const DetailsState.detailsLoading();
      try {
        await _repository.getIssueDetails(data.number);

        await _issueStreamSubscription?.cancel();
        _issueStreamSubscription = _repository.repoStream.listen((data) {
          add(IssueDetailsReceived(data));
        })
          ..onError(handleError);
      } catch (e) {
        debugPrint(e.toString());
        yield const DetailsState.detailsFailure();
      }
    }, issueDetailsReceived: (IssueDetailsReceived data) async* {
      yield DetailsState.detailsReceived(data.issue);
    });
  }

  void handleError(Object error) {
    print(error);
  }

  @override
  Future<void> close() async {
    await super.close();
    await _issueStreamSubscription?.cancel();
  }
}
