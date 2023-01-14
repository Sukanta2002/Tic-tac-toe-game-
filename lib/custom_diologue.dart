import 'package:flutter/material.dart';

class CustomDialogue extends StatelessWidget {
  final Titel;
  final content;
  final VoidCallback callback;
  final actitionText;

  const CustomDialogue(this.Titel, this.content, this.callback,
      [this.actitionText = 'Reset']);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Titel),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: callback,
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: Text(
              actitionText,
            ))
      ],
    );
  }
}
