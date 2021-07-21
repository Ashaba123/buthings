import 'package:buthings/role_checker.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.read<IAuthenticationService>().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('error in authentication'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return RoleChecker(user: snapshot.data);
          } else {
            return LoginScreen();
          }
          return Container();
        });
  }
}
