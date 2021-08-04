import 'package:buthings/constants.dart';
import 'package:buthings/authentication_checker.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/provider/product_provider.dart';
import 'package:buthings/provider/ratings_provider.dart';
import 'package:buthings/provider/user_provider.dart';
import 'package:buthings/repositories/order_repository.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:buthings/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        Provider<IStorageService>(
          create: (_) => StorageService(FirebaseStorage.instance),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<RatingsProvider>(
          create: (context) => RatingsProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        Provider<IOrderRepository>(
          create: (context) => OrderRepository(),
        ),
        StreamProvider(
            create: (context) =>
                context.read<IAuthenticationService>().authStateChanges,
            initialData: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bu Things',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          primarySwatch: Colors.purple,
        ),
        home: AuthenticationChecker(),
      ),
    );
  }
}
