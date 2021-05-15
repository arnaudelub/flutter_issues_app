import 'package:flutter/widgets.dart';
import 'package:flutterissuesapp/core/env/env.dart';
import 'package:flutterissuesapp/core/hive_injectable_module.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GithubApiInjectableModule {
  @lazySingleton
  IGithubApiRepository get githubApiRepository => GithubApiRepository(client);

  @lazySingleton
  IFilterRepository get filterRepository => FilterRepository();

  @lazySingleton
  HttpLink get httpLink => HttpLink(
        'https://api.github.com/graphql',
      );

  @lazySingleton
  AuthLink get authLink => AuthLink(
        getToken: () => 'Bearer ${Env.githubtoken}',
        // OR
        // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      );
  @lazySingleton
  GraphQLClient get client {
    final link = authLink.concat(httpLink);
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
