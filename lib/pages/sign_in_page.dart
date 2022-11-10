import 'package:flutter/material.dart';
import '../design_theme.dart';
import '../widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../widgets/form_title.dart';
import '../widgets/grey_container.dart';
import '../widgets/form_submit_button.dart';
import '../widgets/vertical_padding.dart';
import 'email_sign_in_page.dart';

/// Page where the user signs in
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _submitInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO List',
          style: TextStyle(fontSize: fontSizeLarge),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GreyContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FormTitle(title: "Sign in"),
            const MediumVerticalPadding(),
            _buildGoogleButton(),
            const SmallVerticalPadding(),
            _buildFacebookButton(),
            const SmallVerticalPadding(),
            _buildEmailButton(context),
            const SmallVerticalPadding(),
            _buildOrText(),
            const SmallVerticalPadding(),
            _buildAnonymousButton(),
          ],
        ),
      ),
    );
  }

  FormSubmitButton _buildGoogleButton() {
    return FormSubmitButton(
      title: "Sign in with Google",
      onPressed: _signInWithGoogle,
      iconFilePath: "images/google_logo.png",
      disabled: _submitInProgress,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  FormSubmitButton _buildFacebookButton() {
    return FormSubmitButton(
      title: "Sign in with Facebook",
      onPressed: _signInWithFacebook,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF1877F2),
      iconFilePath: "images/facebook_logo.png",
      disabled: _submitInProgress,
    );
  }

  FormSubmitButton _buildEmailButton(BuildContext context) {
    return FormSubmitButton(
      title: "Sign in with Email",
      onPressed: () => _showEmailSignInForm(context),
      textColor: Colors.white,
      backgroundColor: Colors.teal[700],
      disabled: _submitInProgress,
    );
  }

  Text _buildOrText() {
    return const Text(
      'or',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSizeLarger),
    );
  }

  FormSubmitButton _buildAnonymousButton() {
    return FormSubmitButton(
      title: "Go anonymous",
      onPressed: _goAnonymous,
      backgroundColor: Colors.lime[300],
      textColor: Colors.black,
      disabled: _submitInProgress,
    );
  }

  void _signInWithGoogle() {
    _showNotImplemented();
  }

  void _showNotImplemented() {
    showAlertDialog(context, title: "Not implemented", defaultActionText: "OK");
  }

  void _signInWithFacebook() {
    _showNotImplemented();
  }

  void _showEmailSignInForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const EmailSignInUpPage(),
      ),
    );
  }

  void _goAnonymous() {
    print("Signing in anonymously...");
    markFormAsSubmitting();
    try {
      Auth auth = Provider.of<Auth>(context, listen: false);
      auth.signInAnonymously();
      // Auth stream will update all necessary components
    } catch (error) {
      print("Anonymous sign in failed: $error");
      markFormAsNotSubmitting();
    }
  }

  /// Update state - the form submission is currently in progress
  void markFormAsSubmitting() {
    setState(() {
      _submitInProgress = true;
    });
  }

  /// Update state - not submitting anymore
  void markFormAsNotSubmitting() {
    setState(() {
      _submitInProgress = false;
    });
  }
}
