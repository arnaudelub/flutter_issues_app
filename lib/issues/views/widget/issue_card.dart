import 'package:flutter/material.dart';
import 'package:github_api_repository/github_api_repository.dart';
import 'package:jiffy/jiffy.dart';
import 'package:routemaster/routemaster.dart';

class IssueCard extends StatelessWidget {
  IssueCard({Key? key, required this.issue}) : super(key: key);

  final Edge issue;
  @override
  Widget build(BuildContext context) {
    final node = issue.node;
    final createdAt = Jiffy(node.createdAt).format('dd of MMM yy');
    final author = node.author;
    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text(node.title!),
        subtitle: Text('Opened by: ${author!.login} on $createdAt'),
        leading: Icon(
          issue.node.state == 'CLOSED' ? Icons.close : Icons.folder_open,
        ),
        trailing: const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          radius: 5,
        ),
        onTap: () => Routemaster.of(context).push('/issue/${node.number}'),
      ),
    );
  }
}
