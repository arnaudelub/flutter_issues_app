import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/issues_bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

void main() {
  final _mockGithubRepository = MockGithubRepository();

  group('IssuesBloc', () {
    setUpAll(() {});

    final initialBlocTest = IssuesState.initial();
    final issuesTest = const Issues(
        totalCount: 2,
        edges: [Edge(cursor: '', node: Node(id: '', createdAt: ''))]);
    final issuesTest2 = const Issues(totalCount: 2, edges: [
      Edge(cursor: '', node: Node(id: '', createdAt: '')),
      Edge(cursor: '', node: Node(id: '', createdAt: ''))
    ]);

    test('initialState should be IssuesState.initial()', () {
      expect(IssuesBloc(_mockGithubRepository).state, initialBlocTest);
    });

    void mockCloseRepository() {
      when(_mockGithubRepository.close).thenAnswer((_) => Future.value(null));
    }

    blocTest<IssuesBloc, IssuesState>(
      'should emit state isLoading to true, then to false'
      'with Issues when fetchIssues asked',
      build: () => IssuesBloc(_mockGithubRepository),
      act: (bloc) {
        when(_mockGithubRepository.watchPaginatedIssues)
            .thenAnswer((_) async => issuesTest);
        mockCloseRepository();
        bloc.add(const IssuesEvent.fetchIssuesAsked());
      },
      expect: () => [
        const IssuesState(isLoading: true, moreIsLoading: false),
        IssuesState(isLoading: false, moreIsLoading: false, issues: issuesTest)
      ],
    );
    blocTest<IssuesBloc, IssuesState>(
      'should emit state isLoading to true, then to false'
      'with Issues when setFilter is asked with non null Filter()',
      build: () => IssuesBloc(_mockGithubRepository),
      act: (bloc) {
        when(() => _mockGithubRepository.setStateFilterFromString(''))
            .thenAnswer((invocation) => Future.value(null));
        mockCloseRepository();
        bloc.add(const IssuesEvent.setFiltersAsked(Filter(states: 'open')));
      },
      expect: () => [
        const IssuesState(isLoading: true, moreIsLoading: false),
        IssuesState(isLoading: false, moreIsLoading: false, issues: issuesTest)
      ],
    );
    blocTest<IssuesBloc, IssuesState>(
      'should emit nothing'
      ' when setFilter is asked with null Filter()',
      build: () => IssuesBloc(_mockGithubRepository),
      act: (bloc) {
        when(() => _mockGithubRepository.setStateFilterFromString(''))
            .thenAnswer((invocation) => Future.value(null));
        mockCloseRepository();
        bloc.add(const IssuesEvent.setFiltersAsked(Filter()));
      },
      expect: () => [],
    );

    blocTest<IssuesBloc, IssuesState>(
      'should emit moreIsLoading true then false with more issues'
      ' when fetchMore is asked',
      build: () => IssuesBloc(_mockGithubRepository),
      seed: () => IssuesState(
          isLoading: false, moreIsLoading: false, issues: issuesTest),
      act: (bloc) {
        when(() => _mockGithubRepository.watchPaginatedIssues(after: ''))
            .thenAnswer((_) async => issuesTest);
        mockCloseRepository();
        bloc.add(const IssuesEvent.fetchMoreAsked(''));
      },
      expect: () => [
        IssuesState(isLoading: false, moreIsLoading: true, issues: issuesTest),
        IssuesState(
            isLoading: false, moreIsLoading: false, issues: issuesTest2),
      ],
    );
  });
}
