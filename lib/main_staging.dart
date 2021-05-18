import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
