import 'package:buthings/provider/user_provider.dart';
import 'package:buthings/repositories/user_repository.dart';
import 'package:buthings/screens/admin/admin_dashbord.dart';
import 'package:buthings/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleChecker extends StatefulWidget {
  User? user;
  RoleChecker({this.user});

  @override
  _RoleCheckerState createState() => _RoleCheckerState();
}

class _RoleCheckerState extends State<RoleChecker> {
  @override
  Widget build(BuildContext context) {
    final _usersStream =
        Provider.of<UserProvider>(context).getAllUsers(widget.user!.uid);
    return StreamBuilder<DocumentSnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return Scaffold(body: Center(child: Text('Something went wrong.')));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data!['role'] == 'client') {
            return HomeScreen();
          } else {
            return AdminDashboard();
          }
        });
  }
}
