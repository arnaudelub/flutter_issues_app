import 'package:flutter/material.dart';
import 'package:flutterissuesapp/issues/views/widget/open_close_tag.dart';
import 'package:flutterissuesapp/utils/constants.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

class IssueHeader extends StatelessWidget {
  const IssueHeader({Key? key, required this.issue}) : super(key: key);

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = formatDate(issue.createdAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text.rich(
              TextSpan(text: issue.title, children: [
                TextSpan(
                    text: ' #${issue.number}',
                    style: theme.textTheme.headline5!
                        .copyWith(color: Colors.grey)),
              ]),
              style: theme.textTheme.headline5),
        ),
        const SizedBox(height: kSmallSpacer),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              OpenCloseTag(isClosed: issue.state == close),
              const SizedBox(width: kSmallSpacer),
              Text.rich(
                TextSpan(text: issue.author!.login, children: [
                  TextSpan(
                      text: ' opened this issue on $date',
                      style: theme.textTheme.caption!
                          .copyWith(fontWeight: FontWeight.normal)),
                ]),
                style: theme.textTheme.caption!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
