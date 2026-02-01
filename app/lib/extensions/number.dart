import 'package:flutter/material.dart';

extension NumberExtension on num {
  Widget nashFormat({
    double iconSize = 24,
    Color? iconColor,
    TextStyle? style,
    Widget? leading,
    Widget? trailing,
  }) {
    final parts = toStringAsFixed(2).split('.');

    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(reg, ',');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) leading,
        Image.asset("assets/currency.png", width: iconSize, height: iconSize),
        Text(parts.join('.'), style: style),
        if (trailing != null) trailing,
      ],
    );
  }
}
