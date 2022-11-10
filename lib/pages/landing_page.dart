import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'list_page.dart';
import 'sign_in_page.dart';
import '../services/auth.dart';
import '../services/repository.dart';

/// The main page shown when we start the application
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user != null) {
              _setUserIdInRepo(user.uid, context);
              return const ListPage();
            } else {
              return const SignInPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  void _setUserIdInRepo(String userId, BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    repository.setUid(userId);
  }
}
