import 'package:flutter/material.dart';

/// A text-input field, with everything we need
class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isHidden;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? errorText;
  final bool autofocus;

  const TextInputField({
    this.label = "",
    this.hint = "",
    this.isHidden = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.focusNode,
    this.errorText,
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isHidden,
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: keyboardType,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
