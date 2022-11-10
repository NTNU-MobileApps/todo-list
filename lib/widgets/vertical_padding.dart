import 'package:flutter/material.dart';
import '../design_theme.dart';

/// A small vertical padding
class SmallVerticalPadding extends SizedBox {
  const SmallVerticalPadding({Key? key})
      : super(
          key: key,
          height: smallPadding,
        );
}

/// A medium-sized vertical padding
class MediumVerticalPadding extends SizedBox {
  const MediumVerticalPadding({Key? key})
      : super(
          key: key,
          height: mediumPadding,
        );
}

/// A large-size vertical padding
class LargeVerticalPadding extends SizedBox {
  const LargeVerticalPadding({Key? key})
      : super(
          key: key,
          height: largePadding,
        );
}
