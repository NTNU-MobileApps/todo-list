import '../model/task_list.dart';

/// Generic interface for accessing data storage (database)
abstract class Repository {
  /// Get all TO-DO lists (for the currently authenticated user). Return an empty list on error
  Stream<Iterable<TaskList>> getAllLists();

  /// Add a new list to the storage. Throw an exception on error.
  Future<void> addList(TaskList list);

  /// Update an existing list in the storage. Throw an exception on error.
  Future<void> updateList(TaskList list);

  /// Delete a task list from the storage
  Future<void> deleteList(String listId);

  /// Add a new task to the list. Throw an exception on error.
  Future<void> addTask(TaskList list, String task);

  /// Update an existing task in a list. Throw an exception on error.
  Future<void> updateTask(TaskList list, int taskIndex, String task);

  /// Set current user ID, to be used for all further actions
  /// Note: old streams (already started) may not be closed automatically
  /// when the user changes!
  void setUid(String uid);
}
