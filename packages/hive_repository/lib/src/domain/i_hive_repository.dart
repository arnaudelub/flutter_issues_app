import 'package:hive_repository/hive_repository.dart';

abstract class IHiveRepository {
  Future<void> addIssue({required String id, String? updatedAt});
  bool isCached(String id);
  bool isCachedAndUpdate(String id, String? updatedAt);
  Future<void> switchSettingThemeMode({required bool isDarkMode});
  bool getIsDarkModeCache();
  Future<void> removeIssue(String id);
}
