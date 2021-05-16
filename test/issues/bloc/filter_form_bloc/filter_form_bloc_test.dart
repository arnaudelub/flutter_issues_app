import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';

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
        expect: () => []);
  });
}
