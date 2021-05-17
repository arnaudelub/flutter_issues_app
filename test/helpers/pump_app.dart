// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/issues/issues.dart';
import 'package:flutterissuesapp/l10n/l10n.dart';
import 'package:flutterissuesapp/router/router.dart';
import 'package:flutterissuesapp/theme/cubit/theme_cubit.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routemaster/routemaster.dart';

class MockIssuesBloc extends MockBloc<IssuesEvent, IssuesState>
    implements IssuesBloc {}

class MockDetailsBloc extends MockBloc<DetailsEvent, DetailsState>
    implements DetailsBloc {}

class MockFilterFormBloc extends MockBloc<FilterFormEvent, FilterFormState>
    implements FilterFormBloc {}

class MockThemeCubit extends MockCubit<ThemeData> implements ThemeCubit {}

class MockIssuesState extends Mock implements IssuesState {}

class MockDetailsState extends Mock implements DetailsState {}

class MockFilterFormState extends Mock implements FilterFormState {}

class MockFilterFormEvent extends Mock implements FilterFormEvent {}

class MockDetailsEvent extends Mock implements DetailsEvent {}

class MockIssuesEvent extends Mock implements IssuesEvent {}

class MockHiveRepository extends Mock implements IHiveRepository {}

class MockGithubRepository extends Mock implements IGithubApiRepository {}

class MockFilterRepository extends Mock implements IFilterRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget? widget) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: IssuesBloc(MockGithubRepository()),
          ),
          BlocProvider.value(
            value: DetailsBloc(MockGithubRepository(), MockHiveRepository()),
          ),
          BlocProvider.value(
            value: FilterFormBloc(MockFilterRepository()),
          ),
          BlocProvider.value(
            value: ThemeCubit(MockHiveRepository()),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: const RoutemasterParser(),
          routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) => IssuesRouter.routes),
        ),
      ),
    );
  }
}
