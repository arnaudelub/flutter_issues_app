import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/app/app.dart';
import 'package:flutterissuesapp/issues/issues.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/initiate_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Launch the app correctly', (WidgetTester tester) async {
    await initiateApp();
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(IssuesPage), findsOneWidget);
  });
}
