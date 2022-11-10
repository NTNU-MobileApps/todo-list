/// Represents a single TO-Do list
class TaskList {
  String id;
  String title;
  List<String> items;

  TaskList({this.id = "undefined", required this.title, this.items = const []});

  Map<String, dynamic> toJson() {
    return {"title": title, "items": items};
  }

  /// Convert a dynamic map data (JSON) to a TaskList
  /// Warning: we assume that necessary data is present, the code will crash
  /// if some of the mandatory fields are missing!
  factory TaskList.fromJson(Map<String, dynamic> data, String id) {
    return TaskList(
      id: id,
      title: data['title'],
      items: _convertTasks(data['items']),
    );
  }

  static List<String> _convertTasks(List<dynamic>? data) {
    if (data == null) return [];
    return data.map((item) => item.toString()).toList();
  }

  @override
  String toString() {
    return "Task[$id]-'$title'";
  }

  /// Add a task to the list
  void addTask(String taskName) {
    if (!items.contains(taskName)) {
      items.add(taskName);
    }
  }

  /// Remove a task from the list
  /// taskIndex: the index of the task to remove, starts at 0
  void removeTask(int taskIndex) {
    if (taskIndex < 0 || taskIndex >= items.length) {
      throw IndexError(taskIndex, items);
    }
    items.removeAt(taskIndex);
  }
}
