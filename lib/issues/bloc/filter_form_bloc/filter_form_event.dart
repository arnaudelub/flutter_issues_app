part of 'filter_form_bloc.dart';

@freezed
class FilterFormEvent with _$FilterFormEvent {
  const factory FilterFormEvent.onFilterChanged(String filterString) =
      OnFilterChanged;
  const factory FilterFormEvent.enterPressed() = EnterPressed;
}
