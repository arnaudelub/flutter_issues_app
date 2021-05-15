import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit(this._hiveRepository) : super(ThemeData.dark());
  final IHiveRepository _hiveRepository;
  void setModeFromCache() {
    emit(
      _hiveRepository.getIsDarkModeCache()
          ? ThemeData.dark()
          : ThemeData.light(),
    );
  }

  Future<void> setDarkMode() async {
    await _hiveRepository.switchSettingThemeMode(
      isDarkMode: true,
    );
    emit(ThemeData.dark());
  }

  Future<void> setLightMode() async {
    await _hiveRepository.switchSettingThemeMode(
      isDarkMode: false,
    );
    emit(ThemeData.light());
  }
}
