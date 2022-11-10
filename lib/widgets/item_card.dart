import 'package:flutter/material.dart';

import '../design_theme.dart';

/// Shows an item in a list, as a card
class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.title,
    this.onTap,
    this.onLongPress
  }) : super(key: key);

  final String title;
  final VoidCallback ?onTap;
  final VoidCallback ?onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: smallPadding,
        left: smallPadding,
        right: smallPadding,
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(mediumPadding),
          child: Text(title, style: const TextStyle(fontSize: fontSizeLarger)),
        ),
      ),
    );
  }
}
