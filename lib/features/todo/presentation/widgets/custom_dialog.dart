import 'package:flutter/material.dart';

Future<bool> showCustomDialog(BuildContext context, Widget content) async {
  bool isDone = true;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: EdgeInsets.zero,
          content: content,
        );
      });
  return isDone;
}
