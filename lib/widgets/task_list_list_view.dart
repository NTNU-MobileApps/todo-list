import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task_list.dart';
import '../pages/task_page.dart';
import '../services/repository.dart';
import '../widgets/show_exception_alert_dialog.dart';
import 'item_card.dart';

/// Shows a list where each list-item is a task list
class TaskListListView extends StatelessWidget {
  const TaskListListView({
    Key? key,
    required this.taskLists,
    required this.onLongPress,
  }) : super(key: key);

  final Iterable<TaskList> taskLists;
  final Function(TaskList taskList) onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskLists.length,
      itemBuilder: (context, position) => Dismissible(
        direction: DismissDirection.endToStart,
        key: Key("list-${taskLists.elementAt(position).id}"),
        onDismissed: (direction) =>
            _deleteList(taskLists.elementAt(position), context),
        child: ItemCard(
          title: taskLists.elementAt(position).title,
          onTap: () => _showTaskList(taskLists.elementAt(position), context),
          onLongPress: () =>
              onLongPress(taskLists.elementAt(position)),
        ),
      ),
    );
  }

  /// Show a page for a single Task list
  void _showTaskList(TaskList taskList, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TaskPage(taskList: taskList),
    ));
  }

  void _deleteList(TaskList list, BuildContext context) {
    print("Deleting list ${list.title}");
    final repository = Provider.of<Repository>(context, listen: false);
    try {
      repository.deleteList(list.id);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Could not delete list", exception: e);
    }
  }
}
