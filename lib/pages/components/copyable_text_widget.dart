import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableTextWidget extends StatelessWidget {
  final String text;
  final bool showCopyIcon;

  const CopyableTextWidget({
    super.key,
    required this.text,
    this.showCopyIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(text, style: TextStyle(fontSize: 18)),
          ),
        ),
        if (showCopyIcon)
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied to clipboard!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
      ],
    );
  }
}
