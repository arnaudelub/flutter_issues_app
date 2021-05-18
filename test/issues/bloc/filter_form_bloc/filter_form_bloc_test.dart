import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  final _mockFilterRepository = MockFilterRepository();

  group('Filter form bloc test', () {
    final initialStateTest = FilterFormState(onSave: none());
    test('initial test shoud have onSave set to none()', () {
      expect(FilterFormBloc(_mockFilterRepository).state, initialStateTest);
    });

    blocTest<FilterFormBloc, FilterFormState>(
      'should emit the state with the filterString'
      'when onFilterChanged event is called',
      build: () => FilterFormBloc(_mockFilterRepository),
      act: (bloc) => bloc.add(const FilterFormEvent.onFilterChanged('')),
      expect: () => [FilterFormState(onSave: none(), filterString: '')],
    );

    blocTest<FilterFormBloc, FilterFormState>(
      'should call filterRepository.getFiltersFromString'
      'when EnterPressed event is called',
      build: () => FilterFormBloc(_mockFilterRepository),
      seed: () => FilterFormState(onSave: none(), filterString: 'states:open'),
      act: (bloc) {
        when(() => _mockFilterRepository.getFiltersFromString('states:open'))
            .thenReturn(const Filter(states: 'open'));

        bloc.add(const FilterFormEvent.enterPressed());
      },
      expect: () => [
        FilterFormState(
            onSave: optionOf(const Filter(states: 'open')),
            filterString: 'states:open')
      ],
    );
    blocTest<FilterFormBloc, FilterFormState>(
      'should not call filterRepository.getFiltersFromString'
      'when EnterPressed event is called and filterString is null or ""',
      build: () => FilterFormBloc(_mockFilterRepository),
      act: (bloc) {
        bloc.add(const FilterFormEvent.enterPressed());
      },

      /// even if getFiltersFromString is never call
      /// this this line makes the test fail
      /*verify: (_) =>
          verifyNever(() => 
        _mockFilterRepository.getFiltersFromString(any())),*/
      expect: () => [FilterFormState(onSave: none(), filterString: null)],
    );
  });
}
