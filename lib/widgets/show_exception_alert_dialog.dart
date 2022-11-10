import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/show_alert_dialog.dart';

/// Show an alert dialog which displays data for an exception
Future<void> showExceptionAlertDialog(BuildContext context,
    {required String title, required Exception exception}) {
  return showAlertDialog(
    context,
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
  );
}

String? _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
