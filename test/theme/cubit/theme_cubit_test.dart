import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutterissuesapp/theme/cubit/theme_cubit.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveRepository extends Mock implements IHiveRepository {}

void main() {
  late MockHiveRepository _mockHiveRepository;

  setUpAll(() {
    _mockHiveRepository = MockHiveRepository();
  });
  group('ThemeCubit', () {
    test('initial state is ThemeData.light()', () {
      expect(ThemeCubit(_mockHiveRepository).state, equals(ThemeData.dark()));
    });

    setUpAll(() {
      when(() => _mockHiveRepository.switchSettingThemeMode(
              isDarkMode: any(named: 'isDarkMode')))
          .thenAnswer((invocation) => Future.value(null));
    });
    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeData.dark() when setDarkMode is called',
      build: () => ThemeCubit(_mockHiveRepository),
      act: (cubit) => cubit.setDarkMode(),
      expect: () => [equals(ThemeData.dark())],
    );

    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeData.light() when setLightMode is called',
      build: () => ThemeCubit(_mockHiveRepository),
      act: (cubit) => cubit.setLightMode(),
      expect: () => [equals(ThemeData.light())],
    );
  });
}
