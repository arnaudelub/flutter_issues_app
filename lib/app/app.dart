// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/l10n/l10n.dart';
import 'package:flutterissuesapp/router/router.dart';
import 'package:flutterissuesapp/theme/cubit/theme_cubit.dart';
import 'package:routemaster/routemaster.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure hive is instanciate first
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => getIt<ThemeCubit>()..setModeFromCache(),
      ),
      BlocProvider(
        create: (_) => getIt<IssuesBloc>()
          ..add(
            const IssuesEvent.fetchIssuesAsked(),
          ),
      ),
      BlocProvider(
        create: (_) => getIt<FilterFormBloc>(),
      ),
      BlocProvider(
        create: (_) => getIt<DetailsBloc>(),
      ),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: context.select((ThemeCubit theme) => theme.state),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => IssuesRouter.routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
