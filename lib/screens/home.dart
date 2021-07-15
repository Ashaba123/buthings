import 'package:buthings/components/item_card.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/authentication_checker.dart';
import 'package:buthings/screens/details_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: kDefaultPadding,
                    mainAxisSpacing: kDefaultPadding,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: products[index],
                              ),
                            ),
                          )),
                ),
              ),
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
              color: kPrimaryColor,
            )),
      ],
    );
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
