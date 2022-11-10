import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_add_edit_page.dart';
import '../services/repository.dart';
import '../widgets/show_exception_alert_dialog.dart';
import '../design_theme.dart';
import '../model/task_list.dart';
import '../widgets/task_item_list_view.dart';

/// Page showing a list of tasks for a single TaskList
class TaskPage extends StatefulWidget {
  final TaskList taskList;

  const TaskPage({Key? key, required this.taskList}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TaskList? taskList;

  @override
  Widget build(BuildContext context) {
    taskList ??= widget.taskList;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskList.title),
      ),
      body: TaskListView(
        taskItems: widget.taskList.items,
        listId: widget.taskList.id,
        onDismissed: _onDeleteTask,
        onLongPress: (taskIndex) => _showTaskEditForm(context, taskIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskAddForm(context),
        child: const Icon(Icons.add, size: fontSizeLarge),
      ),
    );
  }

  void _showTaskAddForm(BuildContext context) {
    _showTaskAddEditForm(context);
  }

  void _showTaskEditForm(BuildContext context, int taskIndex) {
    _showTaskAddEditForm(context, taskIndex);
  }

  _showTaskAddEditForm(BuildContext context, [int? taskIndex]) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return TaskAddEditPage(
          taskList: widget.taskList,
          onTaskAdded: _taskListUpdated,
          taskIndex: taskIndex,
        );
      },
    ));
  }

  /// Task list has been updated, need to refresh the widget
  void _taskListUpdated() {
    setState(() {
      taskList = taskList; // The task list has not really changed
    });
    print("Task added, refreshing TaskListPage");
  }

  void _onDeleteTask(int taskIndex) {
    print("Deleting task $taskIndex ...");
    if (taskList != null) {
      taskList!.removeTask(taskIndex);
      final repository = Provider.of<Repository>(context, listen: false);
      try {
        repository.updateList(taskList!);
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: "Could not delete a task", exception: e);
      }
    }
    _taskListUpdated();
  }
}
