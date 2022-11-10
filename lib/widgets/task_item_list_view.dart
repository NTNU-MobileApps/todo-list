import 'package:flutter/material.dart';

import 'item_card.dart';

/// Shows a list displaying all tasks for a specific TaskList
class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
    required this.taskItems,
    required this.listId,
    required this.onDismissed,
    required this.onLongPress,
  }) : super(key: key);

  final List<String> taskItems;
  final String listId;
  final void Function(int taskIndex) onDismissed;
  final void Function(int taskIndex) onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskItems.length,
      itemBuilder: (context, position) => Dismissible(
        key: Key("task-$listId-${_generateItemKey(taskItems[position])}"),
        direction: DismissDirection.endToStart,
        child: ItemCard(
          title: taskItems[position],
          onLongPress: () => onLongPress(position),
        ),
        onDismissed: (direction) => onDismissed(position),
      ),
    );
  }

  String _generateItemKey(String taskName) {
    return "${taskName.hashCode}";
  }
}
