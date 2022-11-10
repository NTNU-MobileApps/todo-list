import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'generic_item_add_page.dart';
import '../model/task_list.dart';
import '../services/repository.dart';
import '../widgets/show_exception_alert_dialog.dart';

/// Page for adding or updating a single task in a list
class TaskAddEditPage extends StatelessWidget {
  final TaskList taskList;
  final VoidCallback onTaskAdded;
  final int? taskIndex;

  bool get isEditing => taskIndex != null;

  const TaskAddEditPage(
      {Key? key,
      required this.taskList,
      required this.onTaskAdded,
      this.taskIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericItemAddEditPage(
      existingNames: taskList.items,
      inputElementHint: "Give the task a name",
      onSubmit: _formSubmitted,
      formTitle: isEditing ? "Update task name" : "Add a task",
      existingName:
          taskIndex != null ? taskList.items.elementAt(taskIndex!) : null,
    );
  }

  void _formSubmitted(String taskName, BuildContext context) async {
    final repository = Provider.of<Repository>(context, listen: false);
    try {
      if (isEditing) {
        print("Updating ${taskList.items.elementAt(taskIndex!)} -> $taskName");
        await repository.updateTask(taskList, taskIndex!, taskName);
      } else {
        print("Adding task $taskName ...");
        await repository.addTask(taskList, taskName);
      }
      onTaskAdded();
      Navigator.of(context).pop(); // Close the "Add a list" window
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Could not add a list", exception: e);
    }
  }
}
