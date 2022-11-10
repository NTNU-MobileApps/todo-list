import 'package:flutter/material.dart';
import '../design_theme.dart';

/// A widget for the main "form submission" button
class FormSubmitButton extends StatelessWidget {
  final String title;
  final String? iconFilePath;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final bool disabled;
  final bool showSpinner;

  const FormSubmitButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.textColor = mainButtonTextColor,
    this.backgroundColor = mainColor,
    this.iconFilePath,
    this.disabled = false,
    this.showSpinner = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool haveIcon = iconFilePath != null;

    var alignment =
        haveIcon ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center;

    var textStyle = TextStyle(color: textColor, fontSize: fontSizeLarger);

    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRounding)),
          ),
        ),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            if (haveIcon)
              Image.asset(iconFilePath!, height: fontSizeExtraLarge),
            if (showSpinner && disabled)
              const Center(child: CircularProgressIndicator())
            else
              Text(title, style: textStyle),
            if (haveIcon) const SizedBox(width: fontSizeExtraLarge)
          ],
        ),
      ),
    );
  }
}
