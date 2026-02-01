import '/config/theme.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  const PasswordTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: obscure,
            cursorColor: context.colorScheme.onSurface,
            style: TextStyle(color: Colors.grey[100]),
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: context.colorScheme.primary,
                  width: 2,
                ),
              ),
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () => setState(() => obscure = !obscure),
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
        ),
      ],
    );
  }
}
