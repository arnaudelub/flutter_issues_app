import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/details/details_bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

void main() {
  final _mockGithubRepository = MockGithubRepository();
  final _mockHiveRepository = MockHiveRepository();

  group('detailsBloc', () {
    test('initial state should be DetailsState.initial()', () {
      expect(DetailsBloc(_mockGithubRepository, _mockHiveRepository).state,
          const DetailsState.initial());
    });
    blocTest<DetailsBloc, DetailsState>(
      'should emit detailsReceived when event issuedetails received is called',
      build: () => DetailsBloc(_mockGithubRepository, _mockHiveRepository),
      act: (bloc) {
        when(() => _mockHiveRepository.addIssue(
                id: any(named: 'id'), updatedAt: any(named: 'updatedAt')))
            .thenAnswer((invocation) async => Future.value(null));
        bloc.add(DetailsEvent.issueDetailsReceived(Issue.empty()));
      },
      expect: () => [DetailsState.detailsReceived(Issue.empty())],
    );
  });
}
