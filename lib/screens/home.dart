import 'package:buthings/components/item_card.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/authentication_checker.dart';
import 'package:buthings/provider/product_provider.dart';
import 'package:buthings/screens/details_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductProvider>().getAllProducts();
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Center(
                child: Text(
                  "Bu Things",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            ),
            StreamBuilder<List<QueryDocumentSnapshot<Product>>>(
              stream: products,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text("Error, Try Again"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: kDefaultPadding,
                        mainAxisSpacing: kDefaultPadding,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                          product: snapshot.data![index],
                          press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    product: snapshot.data![index],
                                  ),
                                ),
                              )),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: AppBarTitle(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: PopupMenuButton<int>(
              icon: Icon(
                Icons.person_pin,
                size: 36,
                color: kPrimaryColor,
              ),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                            "Welcome! ${context.read<IAuthenticationService>().currentUser()!.email}"),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                        value: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.logout,
                              color: kPrimaryColor,
                            ),
                            SizedBox(width: kDefaultPadding / 2),
                            Text("Sign Out")
                          ],
                        ))
                  ]),
        ),
      ],
    );
  }

  onSelected(BuildContext context, int item) {
    if (item == 0) {
      context.read<IAuthenticationService>().signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthenticationChecker()));
    }
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        "For The Love Of...",
        style: TextStyle(
            color: kPrimaryColor,
            fontFamily: "Montserrat",
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
