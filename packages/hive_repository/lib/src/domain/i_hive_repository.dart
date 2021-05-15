abstract class IHiveRepository {
  void addIssue();
  Future<void> switchSettingThemeMode({required bool isDarkMode});
  bool getIsDarkModeCache();
  void removeIssue();
}
