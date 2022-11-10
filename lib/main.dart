import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'pages/landing_page.dart';
import 'design_theme.dart';
import 'services/auth.dart';
import 'services/fb_auth.dart';
import 'services/firestore_repository.dart';
import 'services/repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

/// The root widget for the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => FbAuth(),
      child: Provider<Repository>(
        create: (context) => FirestoreRepository(),
        child: MaterialApp(
          title: "Task list",
          theme: ThemeData(primaryColor: mainColor),
          debugShowCheckedModeBanner: false,
          home: const LandingPage(),
        ),
      ),
    );
  }
}
