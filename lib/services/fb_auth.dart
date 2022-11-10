import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

/// Auth interface implementation, using Firebase authentication
class FbAuth implements Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> signInAnonymously() async {
    final UserCredential credential = await _firebaseAuth.signInAnonymously();
    if (credential.user != null) {
      return credential.user!;
    } else {
      throw Exception("Failed to sign in");
    }
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("FB: Signed in!");
    // If we get so far without Exception, user is present
    return credential.user!;
  }

  @override
  Future<User> register(String email, String password) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    print("FB: Registered");
    // If we get so far without Exception, user is present
    return credential.user!;
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
