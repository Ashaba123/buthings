import 'package:buthings/screens/home.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<IAuthenticationService>().currentUser();

    if (firebaseUser == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
