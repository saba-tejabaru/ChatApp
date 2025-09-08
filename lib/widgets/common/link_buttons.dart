import 'package:flutter/material.dart';

class TextLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const TextLinkButton(this.label, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(label));
  }
}

class OutlinedLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const OutlinedLinkButton(this.label, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(label));
  }
}

