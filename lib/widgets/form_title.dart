import 'package:flutter/material.dart';
import '../design_theme.dart';

/// Title for a form
class FormTitle extends StatelessWidget {
  final String title;

  const FormTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
