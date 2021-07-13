import 'package:buthings/constants.dart';
import 'package:buthings/provider/authentication_checker.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:buthings/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IAuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<IAuthenticationService>().authStateChanges,
            initialData: null),
        Provider<IDatabaseService>(
          create: (_) => DatabaseService(FirebaseFirestore.instance),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bu Things',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          primarySwatch: Colors.purple,
        ),
        home: AuthenticationChecker(),
        initialRoute: "/splash",
        routes: <String, Widget Function(BuildContext context)>{
          "/splash": (context) => AuthenticationChecker(),
        },
      ),
    );
  }
}
