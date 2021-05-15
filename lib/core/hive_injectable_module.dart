import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveInjectableModule {
  @singleton
  @preResolve
  Future<IHiveRepository> get hiveRepository async {
    await Hive.initFlutter();
    final settingsBox = await Hive.openBox(settingsBoxName);
    final issuesBox = await Hive.openBox(issuesBoxName);
    return HiveRepository(
      settingsBox: settingsBox,
      issuesBox: issuesBox,
    );
  }
}
