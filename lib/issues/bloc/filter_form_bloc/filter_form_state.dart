part of 'filter_form_bloc.dart';

@freezed
class FilterFormState with _$FilterFormState {
  factory FilterFormState({
    String? filterString,
    required Option<Filter> onSave,
  }) = _FilterFormState;

  factory FilterFormState.initial() => FilterFormState(onSave: none());
}
