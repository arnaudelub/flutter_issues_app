import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:hive_repository/hive_repository.dart';

class MockSettingsBox<T> extends Mock implements Box<bool> {}

class MockIssuesBox<T> extends Mock implements Box<Map<String, dynamic>> {}

class MockHiveBox<T> extends Mock implements LazyBox<T> {}

void main() {
  late MockSettingsBox<bool> mockSettingsBox;
  late MockIssuesBox<Map<String, dynamic>> mockIssuesBox;
  late IHiveRepository hiveRepository;
  late MockHiveBox<bool> mockHiveBox;

  setUpAll(() {
    mockSettingsBox = MockSettingsBox<bool>();
    hiveRepository =
        HiveRepository(settingsBox: mockSettingsBox, issuesBox: mockIssuesBox);
  });

  group('flutter_issue_adapter', () {
    test('test', () {
      // Todo
    });
  });

  group('Hive Repository', () {
    setUp(() {
      mockIssuesBox = MockIssuesBox();
      mockSettingsBox = MockSettingsBox();
      hiveRepository = HiveRepository(
          settingsBox: mockSettingsBox, issuesBox: mockIssuesBox);

      mockHiveBox = MockHiveBox<bool>();
    });
    test('hiveRepository should be an instance of IHiveRepository', () {
      expect(hiveRepository, isA<IHiveRepository>());
    });

    test('Should cache the isDarkMode boolean value', () async {
      //final putAction = mockSettingsBox.put(themeModeKey, true);
      mockIssuesBox = MockIssuesBox();
      mockSettingsBox = MockSettingsBox();
      hiveRepository = HiveRepository(
          settingsBox: mockSettingsBox, issuesBox: mockIssuesBox);

      mockHiveBox = MockHiveBox<bool>();

      //when(() => putAction).thenAnswer((_) async {});
      //when(() => mockSettingsBox.box).thenReturn(mockHiveBox);
      await hiveRepository.switchSettingThemeMode(isDarkMode: true);
      verify(() => mockHiveBox.put(themeModeKey, true));
      //verify(() async => putAction).called(1);
      //expect(mockSettingsBox.isOpen, isTrue);
    });
  });
}
