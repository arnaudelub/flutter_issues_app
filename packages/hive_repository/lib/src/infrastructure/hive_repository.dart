import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_repository/hive_repository.dart';

const String settingsBoxName = 'settings';
const String issuesBoxName = 'issues';
const String themeModeKey = 'isDarkMode';

class HiveRepository implements IHiveRepository {
  const HiveRepository({required this.settingsBox, required this.issuesBox});

  final Box settingsBox;
  final Box issuesBox;

  bool _isUpdated(String? storedUpdatedAt, String? actualUpdatedAt) =>
      storedUpdatedAt != actualUpdatedAt;

  @override
  bool isCachedAndUpdate(String id, String? updatedAt) {
    final cache = issuesBox.get(id) as Map<dynamic, dynamic>?;

    if (cache != null) {
      if (_isUpdated(cache['updatedAt']!, updatedAt)) {
        removeIssue(id);
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  bool isCached(String id) => issuesBox.get(id) != null;

  @override
  Future<void> addIssue({required String id, String? updatedAt}) async {
    try {
      if (!isCached(id)) {
        await issuesBox.put(id, {'updatedAt': updatedAt});
      }
    } catch (e) {
      debugPrint(e.toString());
      throw CacheError();
    }
  }

  @override
  Future<void> switchSettingThemeMode({required bool isDarkMode}) async {
    try {
      await settingsBox.put(themeModeKey, isDarkMode);
    } catch (e) {
      debugPrint(e.toString());
      throw CacheError();
    }
  }

  @override
  Future<void> removeIssue(String id) async {
    if (isCached(id)) {
      await issuesBox.delete(id);
    }
  }

  @override
  bool getIsDarkModeCache() {
    return settingsBox.get(themeModeKey, defaultValue: false);
  }
}
