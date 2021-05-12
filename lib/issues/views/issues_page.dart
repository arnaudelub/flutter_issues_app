import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/injections.dart';
import 'package:flutterissuesapp/issues/bloc/issues_bloc.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: IssuesView(),
    );
  }
}

class IssuesView extends StatelessWidget {
  const IssuesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesBloc, IssuesState>(builder: (context, state) {
      if (state is IsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is IssuesSuccess) {
        final issues = state.issues;
        return ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              debugPrint(issues[index].toString());
              final issue = issues[index];
              debugPrint(issue.toString());
              return Text(issue!.title);
            });
      } else {
        return Container();
      }
    });
    /*return Query(
      options: QueryOptions(
        document: gql(getIt<IGithubApiRepository>().getPaginatedIssue()),
        variables: {
          'nIssues': defaultPaginatedIssues,
        },
        //pollInterval: 10,
      ),
      builder: ((QueryResult result, {refetch, fetchMore}) {
        if (result.data == null && !result.hasException) {
          return const Text(
            'Loading has completed, but both data and errors are null. '
            'This should never be the case – please open an issue',
          );
        }
        final edges = IssuesDto.fromJson(
                (result.data!['repository'] as Map<String, dynamic>))
            .toDomain();
        final issues = edges.edges.issues;
        return ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              debugPrint(issues[index].toString());
              final issue = issues[index];
              debugPrint(issue.toString());
              return Text(issue!.title);
            });
      }),
    );*/
  }
}
