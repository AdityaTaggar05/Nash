import 'package:flutter/material.dart';

import '/config/theme.dart';

void showSnackBar(BuildContext context, String content, {bool error = true}) {
  final snackBar = SnackBar(
    content: Text(
      content,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: error
            ? context.colorScheme.onError
            : context.colorScheme.onPrimary,
      ),
    ),
    backgroundColor: error
        ? context.colorScheme.error
        : context.colorScheme.primary,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
