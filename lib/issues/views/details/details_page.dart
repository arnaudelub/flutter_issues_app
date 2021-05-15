import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/l10n/l10n.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.issueNumber}) : super(key: key);

  final int issueNumber;

  @override
  Widget build(BuildContext context) {
    print("Issue nmber is $issueNumber");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Issue #$issueNumber'),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<DetailsBloc>(context)
          ..add(DetailsEvent.watchIssueDetailsAsked(issueNumber)),
        child: const DetailsView(),
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
      print(state);
      if (state is DetailsReceived) {
        final issue = state.issue;
        return SingleChildScrollView(
            child: Column(
          children: [
            Text(issue.title),
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
