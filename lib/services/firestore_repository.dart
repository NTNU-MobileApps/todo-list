import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/task_list.dart';
import 'api_path.dart';
import 'repository.dart';

/// Repository implementing data storage in Cloud Firestore database
class FirestoreRepository implements Repository {
  String uid = "unknown";

  /// Set current user ID, to be used for all further actions
  /// Note: old streams (already started) may not be closed automatically
  /// when the user changes!
  @override
  void setUid(String uid) {
    print("UID for DB is now $uid");
    this.uid = uid;
  }

  @override
  Future<void> addList(TaskList list) async =>
      _addDocument(APIPath.lists(uid), list.toJson());

  @override
  Future<void> updateList(TaskList list) =>
      _updateDocument(APIPath.list(uid, list.id), list.toJson());

  @override
  Future<void> addTask(TaskList list, String task) async {
    list.addTask(task);
    return updateList(list);
  }

  @override
  Future<void> updateTask(TaskList list, int taskIndex, String task) {
    list.items.removeAt(taskIndex);
    return addTask(list, task);
  }

  @override
  Future<void> deleteList(String listId) =>
      _deleteDocument(APIPath.list(uid, listId));

  @override
  Stream<Iterable<TaskList>> getAllLists() {
    final path = APIPath.lists(uid);
    return _getCollectionStream<TaskList>(path, TaskList.fromJson);
  }

  /// Get a collection stream at a specific path. Convert each document to the
  /// expected model-object using the [converter] function
  Stream<Iterable<T>> _getCollectionStream<T>(
      String path, T Function(Map<String, dynamic>, String id) converter) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (collection) => collection.docs.map(
        (document) {
          return converter(document.data(), document.id);
        },
      ),
    );
  }

  /// Update a document in the Firestore database
  /// path: path to the document to update
  /// data: the new data for the document
  Future<void> _updateDocument(String path, Map<String, dynamic> data) async {
    print("Updating $path ");
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(data);
  }

  /// Ada a new document to a Firestore collection. A unique ID will be
  /// generated automatically
  /// path: path to the collection
  /// data: data for the new item to be added to the collection
  Future<void> _addDocument(String path, Map<String, dynamic> data) async {
    print("Adding item to $path");
    final collectionReference = FirebaseFirestore.instance.collection(path);
    collectionReference.add(data);
  }

  /// Delete a document from Firestore database
  Future<void> _deleteDocument(String path) async {
    FirebaseFirestore.instance.doc(path).delete();
  }
}
