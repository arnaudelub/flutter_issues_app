import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterissuesapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({Key? key, required this.body}) : super(key: key);

  final String body;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: kSmallSpacer + kAvatarRadius * 2),
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
                      bottomLeft: Radius.circular(kDefaultBorderRadius),
                      bottomRight: Radius.circular(kDefaultBorderRadius))),
              child: Markdown(
                  onTapLink: (link, _, __) => launchUrl(link),
                  shrinkWrap: true,
                  data: body)),
        ),
      ],
    );
  }

  Future<void> launchUrl(String url) async =>
      await canLaunch(url) ? await launch(url) : print('Could not launch $url');
}
