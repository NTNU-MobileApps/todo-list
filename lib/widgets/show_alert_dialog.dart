import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/platform.dart';

/// Show an alert dialog which is adapted to the platform-default look
/// for iOS and Android
/// Code adapted from Andrea Bizzottos Udemy course:
/// https://www.udemy.com/course/flutter-firebase-build-a-complete-app-for-ios-android/
Future<dynamic> showAlertDialog(
  BuildContext context, {
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
}) {
  if (isRunningOniOS()) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content ?? ""),
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content ?? ""),
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
