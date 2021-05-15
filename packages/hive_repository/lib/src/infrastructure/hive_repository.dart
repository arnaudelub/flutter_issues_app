import 'package:hive/hive.dart';
import 'package:hive_repository/hive_repository.dart';

const String settingsBoxName = 'settings';
const String issuesBoxName = 'issues';
const String themeModeKey = 'isDarkMode';

class HiveRepository implements IHiveRepository {
  const HiveRepository({required this.settingsBox, required this.issuesBox});

  final Box settingsBox;
  final Box issuesBox;

  @override
  void addIssue() {
    // TODO: implement addIssue
  }

  @override
  Future<void> switchSettingThemeMode({required bool isDarkMode}) async {
    try {
      await settingsBox.put(themeModeKey, isDarkMode);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  void removeIssue() {
    // TODO: implement removeIssue
  }

  @override
  bool getIsDarkModeCache() {
    return settingsBox.get(themeModeKey, defaultValue: false);
  }
}

class SettingsBox<bool> {
  final LazyBox<bool> box = Hive.lazyBox(settingsBoxName);
}

class IssuesBox<FlutterIssue> {
  final LazyBox<FlutterIssue> box = Hive.lazyBox(issuesBoxName);
}
