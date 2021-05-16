import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterissuesapp/app/app.dart';
import 'package:flutterissuesapp/app/app_bloc_observer.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await initHiveForFlutter();

  runApp(const App());
}
