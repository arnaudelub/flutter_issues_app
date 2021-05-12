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
      print('Foo');
      print("${settingsBox.isOpen}");
      await settingsBox.put('$themeModeKey', isDarkMode);
      print('okkk');
    } catch (e) {
      print("Error is $e");
      throw UnimplementedError();
    }
  }

  @override
  void removeIssue() {
    // TODO: implement removeIssue
  }
}

class SettingsBox {
  final LazyBox<bool> box = Hive.lazyBox(settingsBoxName);
}

class IssuesBox {
  final LazyBox<FlutterIssue> box = Hive.lazyBox(issuesBoxName);
}
