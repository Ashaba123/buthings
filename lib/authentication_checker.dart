import 'package:buthings/role_checker.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read<IAuthenticationService>().currentUser();
    if (user == null) {
      return LoginScreen();
    } else {
      return RoleChecker(user: user);
    }
  }
}
