import 'package:flutter/material.dart';
import 'package:flutterissuesapp/utils/constants.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:github_api_repository/github_api_repository.dart';

class UserHeader extends StatelessWidget {
  const UserHeader(
      {Key? key,
      required this.avatarUrl,
      required this.createdAt,
      required this.name})
      : super(key: key);
  final String createdAt;
  final String name;
  final String? avatarUrl;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = formatDate(createdAt);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: kAvatarRadius,
          backgroundImage: NetworkImage(
            avatarUrl ??
                'https://avatars.githubusercontent.com/u/6489758?s=88&v=4',
          ),
        ),
        const SizedBox(width: kSmallSpacer),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSmallSpacer,
                vertical: kSpacer,
              ),
              decoration: BoxDecoration(
                  color: theme.secondaryHeaderColor,
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kDefaultBorderRadius),
                      topRight: Radius.circular(kDefaultBorderRadius))),
              child: Text.rich(
                TextSpan(text: name, children: [
                  TextSpan(
                      text: ' commented on $date',
                      style: theme.textTheme.caption!
                          .copyWith(fontWeight: FontWeight.normal)),
                ]),
                style: theme.textTheme.caption!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
