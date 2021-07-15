import 'package:buthings/role_checker.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = context.read<IAuthenticationService>().authStateChanges;
    return StreamBuilder<dynamic>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data != null) {
            return RoleChecker(
              user: snapshot.data,
            );
          } else {
            return LoginScreen();
          }
        });
  }
}
