import 'package:flutter/material.dart';

import '../design_theme.dart';

/// A page showing an input form
class FormPage extends StatelessWidget {
  final List<Widget> inputs;
  final String title;

  /// Create an input-form page
  /// title: The title for the form
  /// inputs: the input elements to be shown on the page (aligned vertically)
  ///   padding must also be included as VerticalPadding widgets
  const FormPage({Key? key, required this.inputs, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: fontSizeLarge),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(smallPadding),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(mediumPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: inputs,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
