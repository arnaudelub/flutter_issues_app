import 'package:hive/hive.dart';

part 'flutter_issue_adapter.g.dart';

@HiveType(typeId: 1)
class FlutterIssue {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? updateDate;
}
