import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/issues/views/details/widgets/comment_widget.dart';
import 'package:flutterissuesapp/issues/views/details/widgets/header.dart';
import 'package:flutterissuesapp/l10n/l10n.dart';
import 'package:flutterissuesapp/utils/constants.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.issueNumber}) : super(key: key);

  final int issueNumber;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<IssuesBloc>().add(const IssuesEvent.fetchIssuesAsked());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Issue #$issueNumber'),
        ),
        body: BlocProvider.value(
          value: BlocProvider.of<DetailsBloc>(context)
            ..add(DetailsEvent.watchIssueDetailsAsked(issueNumber)),
          child: const DetailsView(),
        ),
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      if (state is DetailsReceived) {
        final issue = state.issue;
        print(issue);
        return SingleChildScrollView(
            child: Column(
          children: [
            IssueHeader(
              issue: issue,
            ),
            const SizedBox(height: kSpacer),
            CommentWidget(
                body: issue.bodyText!,
                createdAt: issue.createdAt,
                name: issue.author!.login,
                avatarUrl: issue.author!.avatarUrl),
            const SizedBox(height: kSpacer),
            ...List.generate(issue.comments!.edges.length, (index) {
              final comment = issue.comments!.edges[index]!.node;
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpacer),
                child: CommentWidget(
                    body: comment.bodyText!,
                    createdAt: comment.createdAt,
                    name: comment.author!.login,
                    avatarUrl: comment.author!.avatarUrl),
              );
            }),
          ],
        ));
      } else if (state is DetailsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is Initial) {
        return Container();
      } else {
        return Center(child: Text(l10n.genericError));
      }
    });
  }
}
