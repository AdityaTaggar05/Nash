import 'package:flutter/material.dart';

void showSnackBar(context, String content) {
  final snackBar = SnackBar(
        content: Text(
          content,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
}