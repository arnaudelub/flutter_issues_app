import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterissuesapp/issues/bloc/bloc.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

import 'issue_card.dart';

class InfiniteScrollWidget extends StatefulWidget {
  InfiniteScrollWidget({Key? key, required this.issues}) : super(key: key);
  final List<Edge?> issues;
  @override
  _InfiniteScrollWidgetState createState() => _InfiniteScrollWidgetState();
}

class _InfiniteScrollWidgetState extends State<InfiniteScrollWidget> {
  final ScrollController _scrollController = ScrollController();
  late List<Edge?> issues;
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
            .add(FetchMoreEvent.fetchMore(previousList: widget.issues));
      }
    }
  }

  void onMoreReceived(List<Edge?> moreIssue) {
    if (moreIssue.isNotEmpty) {
      setState(() {
        issues = [...issues, ...moreIssue];
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
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              return IssueCard(issue: issue!);
            }),
      ),
    );
  }
}
