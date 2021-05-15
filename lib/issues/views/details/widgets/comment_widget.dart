import 'package:flutter/material.dart';
import 'package:flutterissuesapp/issues/views/details/widgets/content_box.dart';
import 'package:flutterissuesapp/issues/views/details/widgets/user_header.dart';
import 'package:flutterissuesapp/utils/constants.dart';
import 'package:github_api_repository/github_api_repository.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key,
      required this.body,
      required this.createdAt,
      required this.name,
      required this.avatarUrl})
      : super(key: key);

  final String name;
  final String createdAt;
  final String body;
  final String? avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacer),
      child: Column(
        children: [
          UserHeader(avatarUrl: avatarUrl, createdAt: createdAt, name: name),
          ContentBox(body: body)
        ],
      ),
    );
  }
}
