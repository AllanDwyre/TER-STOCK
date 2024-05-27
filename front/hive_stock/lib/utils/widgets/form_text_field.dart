import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final Function(String)? onChanged;
  final bool? obscureText;

  const FormTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.onChanged,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
