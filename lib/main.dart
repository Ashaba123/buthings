import 'package:buthings/constants.dart';
import 'package:buthings/screens/home.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/screens/signup_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IAuthenicationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<IAuthenicationService>().authStateChanges,
            initialData: null)
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
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignUpScreen(),
          "/home": (context) => HomeScreen()
        },
      ),
    );
  }
}

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<IAuthenicationService>().curentUser();

    if (firebaseUser == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
