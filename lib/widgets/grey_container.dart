import 'package:flutter/material.dart';
import '../design_theme.dart';

/// A basic grey container, can be used as the main content-container for
/// each activity screen
class GreyContainer extends Container {
  GreyContainer({Widget? child, Key? key})
      : super(
          key: key,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(mediumPadding),
            child: child,
          ),
        );
}
