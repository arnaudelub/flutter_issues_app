import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:hive_repository/hive_repository.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockSettingsBox<T> extends Mock implements Box<bool> {}

class MockIssuesBox<T> extends Mock implements Box<Map<String, dynamic>> {}

void main() {
  late MockHiveInterface _mockHiveInterface;
  late MockSettingsBox<bool> _mockSettingsBox;
  late MockIssuesBox<Map<String, dynamic>> _mockIssuesBox;
  late IHiveRepository _hiveRepository;

  setUpAll(() {
    _mockHiveInterface = MockHiveInterface();
    _mockSettingsBox = MockSettingsBox<bool>();
    _mockIssuesBox = MockIssuesBox<Map<String, dynamic>>();
    _hiveRepository = HiveRepository(
        settingsBox: _mockSettingsBox, issuesBox: _mockIssuesBox);
    registerFallbackValue(_mockHiveInterface);
  });

  group('Hive Repository', () {
    test('hiveRepository should be an instance of IHiveRepository', () {
      expect(_hiveRepository, isA<IHiveRepository>());
    });

    test('Should cache the isDarkMode boolean value', () async {
      when(() => _mockSettingsBox.put(any(), any()))
          .thenAnswer((invocation) => Future.value(null));
      await _hiveRepository.switchSettingThemeMode(isDarkMode: true);
      verify(() => _mockSettingsBox.put(themeModeKey, true)).called(1);
      final res = _mockSettingsBox.get(themeModeKey);
      print(res);
    });
  });
}
