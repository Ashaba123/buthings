import 'package:buthings/screens/home.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bu Things',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SafeArea(child: LoginScreen()),
    );
  }
}
