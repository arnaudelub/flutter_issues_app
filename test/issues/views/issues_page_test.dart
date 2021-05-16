import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/issues.dart';

import '../../helpers/helpers.dart';

const centerProgressKey = Key('center progress');
void main() {
  setUpAll(() {
    //registerFallbackValue(MockIssuesState());
    //registerFallbackValue(MockIssuesEvent());
  });
  group('IssuesPage', () {
    testWidgets('Should find the IssueView widget', (tester) async {
      await tester.pumpApp(const IssuesPage());
      expect(find.byType(IssuesView), findsOneWidget);
    });
  });
}
