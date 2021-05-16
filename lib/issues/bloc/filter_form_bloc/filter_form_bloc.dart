import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:injectable/injectable.dart';

part 'filter_form_state.dart';
part 'filter_form_event.dart';

part 'filter_form_bloc.freezed.dart';

@injectable
class FilterFormBloc extends Bloc<FilterFormEvent, FilterFormState> {
  FilterFormBloc(this._filterRepository) : super(FilterFormState.initial());

  final IFilterRepository _filterRepository;
  @override
  Stream<FilterFormState> mapEventToState(FilterFormEvent event) async* {
    yield* event.map(onFilterChanged: (OnFilterChanged value) async* {
      yield state.copyWith(filterString: value.filterString, onSave: none());
    }, enterPressed: (EnterPressed value) async* {
      Filter? filter;
      if (state.filterString != '' && state.filterString != null) {
        filter = _filterRepository.getFiltersFromString(
          state.filterString!,
        );
        yield state.copyWith(onSave: optionOf(filter));
      } else {
        yield state;
      }
    });
  }
}
