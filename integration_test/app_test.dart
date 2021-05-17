import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/app/app.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/issues/issues.dart';
import 'package:flutterissuesapp/issues/views/details/details_page.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test/helpers/helpers.dart';
import 'helpers/initiate_app.dart';

class MockDetailsBloc extends MockBloc<DetailsEvent, DetailsState>
    implements DetailsBloc {}

class FakeDetailsEvent extends Mock implements DetailsEvent {}

class FakeDetailsState extends Mock implements DetailsState {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeDetailsState());
    registerFallbackValue(FakeDetailsEvent());
  });
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
    // Take a screenshot not available with SDK
    // await binding.takeScreenshot('issues_page');
  });

  testWidgets('Should navigate to details page when an issue card is tapped',
      (WidgetTester tester) async {
    final mockDetailsBloc = MockDetailsBloc();
    const issueCardFinderTest = Key('issue card 1');
    const testIssue = Issue(
        id: 'foo',
        author:
            Author(login: 'Arnaud', avatarUrl: 'https://placholder.com/250'),
        title: 'title',
        state: 'open',
        bodyText: 'hello world',
        createdAt: 'created date',
        updatedAt: 'update date',
        comments: EdgeParent(totalCount: 2, edges: [
          Edge(
              cursor: '',
              node: Node(
                  id: '',
                  createdAt: 'date',
                  bodyText: 'hi',
                  author: Author(
                      login: 'joe', avatarUrl: 'https://placeholder.com/250'))),
          Edge(
              cursor: '',
              node: Node(
                  id: '',
                  createdAt: 'date',
                  bodyText: 'hi 2',
                  author: Author(
                      login: 'joe', avatarUrl: 'https://placeholder.com/250')))
        ]),
        labels: EdgeParent(totalCount: 0, edges: []));
    whenListen(
      mockDetailsBloc,
      Stream.fromIterable([testIssue]),
      initialState: 0,
    );
    final pumpWidgetTest = BlocProvider<DetailsBloc>.value(
        value: mockDetailsBloc, child: const DetailsView());
    await tester.pumpApp(pumpWidgetTest);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(issueCardFinderTest));
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsOneWidget);
    expect(find.byKey(headerKey), findsOneWidget);
    expect(find.byKey(postBoxKey), findsOneWidget);
    expect(find.byKey(commentBoxKey), findsNWidgets(2));
  });
}
