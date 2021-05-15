part of 'fetch_more_bloc.dart';

@freezed
class FetchMoreEvent with _$FetchMoreEvent {
  const factory FetchMoreEvent.fetchMore({required List<Edge?> previousList}) =
      FetchMore;
}
