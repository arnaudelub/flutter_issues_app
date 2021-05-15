import 'package:flutter/material.dart';
import 'package:flutterissuesapp/utils/constants.dart';

const String close = 'Closed';
const String open = 'Open';

class OpenCloseTag extends StatelessWidget {
  const OpenCloseTag({Key? key, this.isClosed = false}) : super(key: key);

  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    final color = isClosed ? Colors.red : Colors.greenAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      decoration: BoxDecoration(
        color: isClosed
            ? Colors.red.withOpacity(0.2)
            : Colors.green.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(kDefaultRadius)),
        border: Border.all(color: color),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.info_outline_rounded, color: color),
        Text(isClosed ? close : open, style: TextStyle(color: color)),
      ]),
    );
  }
}
