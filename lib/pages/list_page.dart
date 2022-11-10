import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design_theme.dart';
import '../model/task_list.dart';
import '../services/auth.dart';
import '../services/repository.dart';
import '../widgets/task_list_list_view.dart';
import 'task_list_add_edit_page.dart';

/// Page showing all the available Task-lists
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Repository repository = Provider.of<Repository>(context);

    return StreamBuilder<Iterable<TaskList>>(
        stream: repository.getAllLists(),
        builder: (BuildContext context, snapshot) {
          Iterable<TaskList>? taskLists = snapshot.data;
          bool isLoading = snapshot.connectionState != ConnectionState.active ||
              taskLists == null;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Your lists",
                style: TextStyle(fontSize: fontSizeLarge),
              ),
              actions: [
                IconButton(
                  onPressed: () => _signOut(context),
                  icon: const Icon(Icons.logout),
                  tooltip: "Sign out",
                  iconSize: fontSizeLarge,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showListAddForm(context, taskLists),
              child: const Icon(Icons.add, size: fontSizeLarge),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TaskListListView(
                    taskLists: taskLists,
                    onLongPress: (TaskList taskList) =>
                        _showListUpdateForm(context, taskLists, taskList),
                  ),
          );
        });
  }

  void _signOut(BuildContext context) {
    try {
      Auth auth = Provider.of<Auth>(context, listen: false);
      auth.signOut();
      // Auth stream will notify all listeners
    } catch (error) {
      print("Error while signing out: $error");
    }
  }

  /// Show a form for adding a new task list
  void _showListAddForm(BuildContext context, Iterable<TaskList>? todoLists) {
    _showListAddEditForm(context, todoLists);
  }

  /// Show a form for updating an existing task list (it's name, not items)
  void _showListUpdateForm(
      BuildContext context, Iterable<TaskList>? todoLists, TaskList taskList) {
    _showListAddEditForm(context, todoLists, taskList);
  }

  /// Show the form for adding a new list
  void _showListAddEditForm(BuildContext context, Iterable<TaskList>? todoLists,
      [TaskList? taskList]) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        List<String> listNames = _getListNames(todoLists);
        return TaskListAddEditPage(
          existingNames: listNames,
          taskList: taskList,
        );
      },
    ));
  }

  /// Get names of all provided task lists
  List<String> _getListNames(Iterable<TaskList>? todoLists) {
    List<String> listNames;
    if (todoLists != null) {
      listNames = todoLists.map((t) => t.title).toList();
    } else {
      listNames = [];
    }
    return listNames;
  }
}
