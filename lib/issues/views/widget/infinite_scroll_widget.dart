import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

import 'issue_card.dart';

class InfiniteScrollWidget extends StatefulWidget {
  InfiniteScrollWidget({Key? key, required this.issues}) : super(key: key);
  final Issues issues;
  @override
  _InfiniteScrollWidgetState createState() => _InfiniteScrollWidgetState();
}

class _InfiniteScrollWidgetState extends State<InfiniteScrollWidget> {
  final ScrollController _scrollController = ScrollController();
  late Issues issues;
  bool isFetching = false;
  @override
  void initState() {
    super.initState();
    issues = widget.issues;
    _scrollController.addListener(onScroll);
  }

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = 200;
    if (maxScroll - currentScroll <= delta) {
      if (!isFetching) {
        setState(() => isFetching = true);
        context
            .read<FetchMoreBloc>()
            .add(FetchMoreEvent.fetchMore(previousList: issues));
      }
    }
  }

  void onMoreReceived(List<Edge?> moreIssue) {
    if (moreIssue.isNotEmpty) {
      final appendedEdges = [...issues.edges, ...moreIssue];
      setState(() {
        issues = issues.copyWith(edges: appendedEdges);
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchMoreBloc, FetchMoreState>(
      listener: (context, state) {
        if (state == const FetchMoreState.loadInProgress()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: LinearProgressIndicator(),
          ));
        } else if (state is LoadSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onMoreReceived(state.issues);
        } else if (state is LoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error'),
          ));
        }
      },
      child: Container(
        child: ListView.builder(
            controller: _scrollController,
            addSemanticIndexes: true,
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: issues.edges.length,
            itemBuilder: (context, index) {
              final issue = issues.edges[index];
              return IssueCard(issue: issue!);
            }),
      ),
    );
  }
}
