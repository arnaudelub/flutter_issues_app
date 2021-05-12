import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  void setDarkMode() => emit(ThemeData.dark());
  void setLightMode() => emit(ThemeData.light());
}
