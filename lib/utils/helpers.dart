import 'package:jiffy/jiffy.dart';

String formatDate(String date) => Jiffy(date).format('dd of MMM yy');
