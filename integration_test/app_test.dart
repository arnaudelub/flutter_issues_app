import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/app/app.dart';
import 'package:flutterissuesapp/issues/issues.dart';
import 'package:flutterissuesapp/issues/views/details/details_page.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/initiate_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Launch the app correctly', (WidgetTester tester) async {
    await initiateApp();
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(IssuesPage), findsOneWidget);

    // This page should contains the search form and the sort button
    // and an infinite scroll with the issues cards
    expect(find.byKey(searchFormKey), findsOneWidget);
    expect(find.byKey(sortButtonKey), findsOneWidget);
    expect(find.byKey(infinitScrollKey), findsOneWidget);
    expect(find.byType(IssueCard), findsWidgets);
  });

  testWidgets('Should navigate to details page when an issue card is tapped',
      (WidgetTester tester) async {
    const issueCardFinderTest = Key('issue card 1');
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(issueCardFinderTest));
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsOneWidget);
  });
}
