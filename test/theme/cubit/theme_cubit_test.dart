import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mediamarkt/theme/cubit/theme_cubit.dart';

void main() {
  group('ThemeCubit', () {
    test('initial state is ThemeData.light()', () {
      expect(ThemeCubit().state, equals(ThemeData.light()));
    });

    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeData.dark() when setDarkMode is called',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.setDarkMode(),
      expect: () => [equals(ThemeData.dark())],
    );

    blocTest<ThemeCubit, ThemeData>(
      'emits ThemeData.light() when setLightMode is called',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.setLightMode(),
      expect: () => [equals(ThemeData.light())],
    );
  });
}
