import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

import 'issue_card.dart';

class InfiniteScrollWidget extends StatefulWidget {
  InfiniteScrollWidget({
    Key? key,
    required this.issues,
  }) : super(key: key);
  final Issues issues;
  @override
  _InfiniteScrollWidgetState createState() => _InfiniteScrollWidgetState();
}

class _InfiniteScrollWidgetState extends State<InfiniteScrollWidget> {
  final ScrollController _scrollController = ScrollController();
  bool isFetching = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
  }

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      context
          .read<IssuesBloc>()
          .add(IssuesEvent.fetchMoreAsked(widget.issues.edges.last!.cursor));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(kDefaultPadding),
          itemCount: widget.issues.edges.length,
          itemBuilder: (context, index) {
            final issue = widget.issues.edges[index];
            return IssueCard(key: Key('issue card $index'), issue: issue!);
          }),
    );
  }
}
