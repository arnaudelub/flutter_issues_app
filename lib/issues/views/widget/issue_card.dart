import 'package:flutter/material.dart';
import 'package:flutterissuesapp/issues/views/widget/open_close_tag.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:routemaster/routemaster.dart';

class IssueCard extends StatelessWidget {
  IssueCard({Key? key, required this.issue}) : super(key: key);

  final Edge issue;
  @override
  Widget build(BuildContext context) {
    final node = issue.node;
    final createdAt = formatDate(node.createdAt);

    /// If filtering with author:[@me]
    /// the query return ```__author: null__```
    /// and because the token used to query the API
    /// [@me] is actually me!
    /// Using [@me] also return all issues where Author is [null]
    final author =
        node.author ?? const Author(login: 'arnaudelub', avatarUrl: null);
    final theme = Theme.of(context);
    print(issue);
    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text.rich(TextSpan(text: node.title!, children: [
          TextSpan(text: ' #${node.number}', style: theme.textTheme.caption!)
        ])),
        subtitle: Text('Opened by: ${author.login} on $createdAt'),
        leading: OpenCloseTag(isClosed: issue.node.state == 'CLOSED'),
        trailing: node.isCached ?? false
            ? const SizedBox()
            : const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                radius: 5,
              ),
        onTap: () => Routemaster.of(context).push('/issue/${node.number}'),
      ),
    );
  }
}
