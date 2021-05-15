part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState.initial() = Initial;
  const factory DetailsState.detailsLoading() = DetailsLoading;
  const factory DetailsState.detailsReceived(Issue issue) = DetailsReceived;
  const factory DetailsState.detailsFailure() = DetailsFailure;
}
