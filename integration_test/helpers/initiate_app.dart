import 'package:flutter/widgets.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> initiateApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await initHiveForFlutter();
}
