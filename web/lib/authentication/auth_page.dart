import 'package:flutter/material.dart';
import 'package:hometech/signin_screen.dart';
import 'package:hometech/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSignInScreen = true;

  void toggleScreens() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return SignInScreen(showSignUpScreen: toggleScreens);
    } else {
      return SignUpScreen(showSignInScreen: toggleScreens,);
    }
  }
}
