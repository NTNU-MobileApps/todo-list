import 'package:firebase_auth/firebase_auth.dart';

/// Authentication interface
abstract class Auth {
  /// Sign in anonymously. Return the logged in user.
  /// Throw an exception on error.
  Future<User> signInAnonymously();

  /// Sign in with email and password. Return the logged in user.
  /// Throw an exception on error.
  Future<User> signInWithEmailAndPassword(String email, String password);

  /// Register a new account with email and password. Return the logged in user.
  /// Throw an exception on error.
  Future<User> register(String email, String password);

  /// Currently logged in user, null when not logged in.
  User? get currentUser;

  /// A stream where all updates to authenticated user will be published:
  /// whenever a user authenticates, the respective object is published to
  /// the stream. Whenever a user signs out, null is published to the stream.
  Stream<User?> get authStateChanges;

  /// Sign out
  /// Throw an exception on error.
  Future<void> signOut();
}
