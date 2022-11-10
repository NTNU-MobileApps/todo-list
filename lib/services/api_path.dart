/// Holds a collection of all the used API paths for Firebase
class APIPath {
  static String list(String uid, String listId) => "users/$uid/lists/$listId";
  static String lists(String uid) => "users/$uid/lists";
}