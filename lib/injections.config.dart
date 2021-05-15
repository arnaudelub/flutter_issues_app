// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:github_api_repository/github_api_repository.dart' as _i4;
import 'package:graphql_flutter/graphql_flutter.dart' as _i3;
import 'package:hive_repository/hive_repository.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import 'core/github_api_injectable_module.dart' as _i11;
import 'core/hive_injectable_module.dart' as _i12;
import 'issues/bloc/details/details_bloc.dart' as _i7;
import 'issues/bloc/fetch_more_bloc/fetch_more_bloc.dart' as _i8;
import 'issues/bloc/filter_form_bloc/filter_form_bloc.dart' as _i9;
import 'issues/bloc/issues_bloc.dart' as _i10;
import 'theme/cubit/theme_cubit.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final githubApiInjectableModule = _$GithubApiInjectableModule();
  final hiveInjectableModule = _$HiveInjectableModule();
  gh.lazySingleton<_i3.AuthLink>(() => githubApiInjectableModule.authLink);
  gh.lazySingleton<_i3.GraphQLClient>(() => githubApiInjectableModule.client);
  gh.lazySingleton<_i3.HttpLink>(() => githubApiInjectableModule.httpLink);
  gh.lazySingleton<_i4.IFilterRepository>(
      () => githubApiInjectableModule.filterRepository);
  gh.lazySingleton<_i4.IGithubApiRepository>(
      () => githubApiInjectableModule.githubApiRepository);
  gh.factory<_i5.ThemeCubit>(() => _i5.ThemeCubit(get<_i6.IHiveRepository>()));
  gh.factory<_i7.DetailsBloc>(
      () => _i7.DetailsBloc(get<_i4.IGithubApiRepository>()));
  gh.factory<_i8.FetchMoreBloc>(
      () => _i8.FetchMoreBloc(get<_i4.IGithubApiRepository>()));
  gh.factory<_i9.FilterFormBloc>(
      () => _i9.FilterFormBloc(get<_i4.IFilterRepository>()));
  gh.factory<_i10.IssuesBloc>(() => _i10.IssuesBloc(
      get<_i4.IGithubApiRepository>(), get<_i9.FilterFormBloc>()));
  await gh.singletonAsync<_i6.IHiveRepository>(
      () => hiveInjectableModule.hiveRepository,
      preResolve: true);
  return get;
}

class _$GithubApiInjectableModule extends _i11.GithubApiInjectableModule {}

class _$HiveInjectableModule extends _i12.HiveInjectableModule {}
