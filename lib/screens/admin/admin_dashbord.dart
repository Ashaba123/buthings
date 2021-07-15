import 'package:buthings/authentication_checker.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BU Things Admin"),
        actions: [
          IconButton(
              tooltip: "Sign Out",
              onPressed: () {
                context.read<IAuthenticationService>().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthenticationChecker()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
