import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:injectable/injectable.dart';

part 'fetch_more_state.dart';
part 'fetch_more_event.dart';
part 'fetch_more_bloc.freezed.dart';

@injectable
class FetchMoreBloc extends Bloc<FetchMoreEvent, FetchMoreState> {
  FetchMoreBloc(this._repository) : super(const _Initial());
  final IGithubApiRepository _repository;

  @override
  Stream<FetchMoreState> mapEventToState(FetchMoreEvent event) async* {
    yield* event.map(fetchMore: (FetchMore data) async* {
      try {
        yield const LoadInProgress();
        final startCursor = data.previousList.edges.last!.cursor;
        final moreIssues =
            await _repository.watchPaginatedIssues(after: startCursor);
        yield LoadSuccess([...data.previousList.edges, ...moreIssues.edges]);
      } on Exception catch (_) {
        yield const LoadFailure();
      }
    });
  }
}
