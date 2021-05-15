part of 'fetch_more_bloc.dart';

@freezed
class FetchMoreState with _$FetchMoreState {
  const factory FetchMoreState.initial() = _Initial;
  const factory FetchMoreState.loadInProgress() = LoadInProgress;
  const factory FetchMoreState.loadSuccess(List<Edge?> issues) = LoadSuccess;
  const factory FetchMoreState.loadFailure() = LoadFailure;
}
