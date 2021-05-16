import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/details/details_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/issues_bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

void main() {
  final _mockGithubRepository = MockGithubRepository();
  final _mockHiveRepository = MockHiveRepository();

  final instanceBloc = DetailsBloc(_mockGithubRepository, _mockHiveRepository);
  group('detailsBloc', () {
    test('initial state should be DetailsState.initial()', () {
      expect(instanceBloc.state, const DetailsState.initial());
    });
    /*blocTest('should emit detailsLoading then issueDetailsReceived when watchIssueDetailsAsked succeed', 
        build: () => instanceBloc,
        act: (bloc) => ,
        expect: () => ,
    );*/
  });
}
