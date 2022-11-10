import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'generic_item_add_page.dart';
import '../model/task_list.dart';
import '../services/repository.dart';
import '../widgets/show_exception_alert_dialog.dart';

/// A page for adding a new TaskList
class TaskListAddEditPage extends StatelessWidget {
  final List<String> existingNames;
  final TaskList? taskList;

  bool get isEditing => taskList != null;

  const TaskListAddEditPage(
      {Key? key, required this.existingNames, this.taskList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericItemAddEditPage(
      existingNames: existingNames,
      inputElementHint: "Name of the list",
      onSubmit: _formSubmitted,
      formTitle: isEditing ? "Update the list" : "Add a task list",
      existingName: taskList != null ? taskList!.title : null,
    );
  }

  /// Handle the submission of the form
  void _formSubmitted(String listName, BuildContext context) async {
    final repository = Provider.of<Repository>(context, listen: false);
    try {
      if (taskList != null) {
        print("Updating task list $listName ...");
        taskList!.title = listName;
        await repository.updateList(taskList!);
      } else {
        print("Adding task list $listName ...");
        final taskList = TaskList(title: listName);
        await repository.addList(taskList);
      }
      Navigator.of(context).pop(); // Close the "Add a list" window
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Operation failed", exception: e);
    }
  }
}
