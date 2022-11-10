import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design_theme.dart';
import '../services/auth.dart';
import '../widgets/form_page.dart';
import '../widgets/show_exception_alert_dialog.dart';
import '../widgets/form_submit_button.dart';
import '../widgets/text_input_field.dart';
import '../widgets/vertical_padding.dart';

enum EmailFormType { signIn, signUp }

// Represents the page for SignIn/SignUp with email
class EmailSignInUpPage extends StatefulWidget {
  const EmailSignInUpPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInUpPage> createState() => _EmailSignInUpPageState();
}

class _EmailSignInUpPageState extends State<EmailSignInUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  EmailFormType _formType = EmailFormType.signIn;
  bool _submitting = false;

  bool get isSignIn => _formType == EmailFormType.signIn;

  String get email => emailController.text;

  String get password => passwordController.text;

  bool get _emailEmpty => email.isEmpty;

  bool get _passwordEmpty => password.isEmpty;

  bool get _isSubmissionDisabled =>
      _emailEmpty || _passwordEmpty || _submitting;

  bool _wrongEmailSubmitted = false;
  bool _wrongPasswordSubmitted = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FormPage(
      inputs: [
        _createEmailInput(),
        _createPasswordInput(),
        const MediumVerticalPadding(),
        _createSubmitButton(context),
        const MediumVerticalPadding(),
        _createFormTogglingButton(),
      ],
      title: isSignIn ? "Sign in" : "Register",
    );
  }

  Widget _createSubmitButton(BuildContext context) {
    return FormSubmitButton(
      title: isSignIn ? "Sign in" : "Create an account",
      onPressed: () => _submitForm(context),
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      disabled: _isSubmissionDisabled,
      showSpinner: _submitting,
    );
  }

  Widget _createEmailInput() {
    return TextInputField(
      label: "Email",
      hint: "john@doe.com",
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => _clearEmailErrors(),
      focusNode: emailFocusNode,
      autofocus: true,
      errorText: _wrongEmailSubmitted ? "Oops. Wrong email?" : null,
    );
  }

  Widget _createPasswordInput() {
    return TextInputField(
      label: "Password",
      controller: passwordController,
      onChanged: (_) => _clearPasswordErrors(),
      isHidden: true,
      focusNode: passwordFocusNode,
      errorText: _wrongPasswordSubmitted ? "Wrong password" : null,
    );
  }

  Widget _createFormTogglingButton() {
    final String buttonText = isSignIn
        ? "Need an account? Register!"
        : "Already have an account? Sign in!";
    return TextButton(
      onPressed: !_submitting ? _switchFormType : null,
      child: Text(buttonText, style: const TextStyle(fontSize: fontSizeMedium)),
    );
  }

  /// Submit the form: either sign in or register
  void _submitForm(BuildContext context) async {
    setState(() {
      _submitting = true;
    });
    bool emailError = false;
    bool passwordError = false;
    String? errorTitle;
    Exception? exception;
    try {
      Auth auth = Provider.of<Auth>(context, listen: false);
      if (isSignIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.register(email, password);
      }

      // This to ensure that navigation will work in an async function
      if (!mounted) return;

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      exception = e;
      print("Error: ${e.code}");
      if (e.code == "wrong-password") {
        errorTitle = "Wrong password";
        passwordError = true;
      } else if (e.code == "user-not-found") {
        errorTitle = "Non-existing email";
        emailError = true;
      } else if (e.code == "invalid-email") {
        errorTitle = "Wrong email format";
        emailError = true;
      } else if (e.code == "too-many-requests") {
        errorTitle = "Too many requests, wait a minute!";
      }
    }

    // This to ensure that navigation will work in an async function
    if (!mounted) return;

    if (exception != null && errorTitle != null) {
      showExceptionAlertDialog(context,
          title: errorTitle, exception: exception);
    }

    setState(() {
      _submitting = false;
      _wrongEmailSubmitted = emailError;
      _wrongPasswordSubmitted = passwordError;
    });
  }

  /// Switch between SignIn / Register
  void _switchFormType() {
    setState(() {
      _formType = _formType == EmailFormType.signIn
          ? EmailFormType.signUp
          : EmailFormType.signIn;
    });
    emailController.clear();
    passwordController.clear();
  }

  /// Clear eventual errors in the email field, force state update and hence
  /// force widget rebuild
  void _clearEmailErrors() {
    setState(() {
      _wrongEmailSubmitted = false;
    });
  }

  /// Clear eventual errors in the password field, force state update and hence
  /// force widget rebuild
  void _clearPasswordErrors() {
    setState(() {
      _wrongPasswordSubmitted = false;
    });
  }
}
