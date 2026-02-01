import '/config/theme.dart';
import 'package:flutter/material.dart';

class CreationButton extends StatefulWidget {
  final Future? Function() onPressed;
  final String title;

  const CreationButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  State<CreationButton> createState() => _CreationButtonState();
}

class _CreationButtonState extends State<CreationButton> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
