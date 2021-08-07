import 'package:buthings/authentication_checker.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/provider/product_provider.dart';
import 'package:buthings/provider/ratings_provider.dart';
import 'package:buthings/provider/user_provider.dart';
import 'package:buthings/screens/admin/admin_feedback_screen.dart';
import 'package:buthings/screens/admin/admin_recent_orders.dart';
import 'package:buthings/screens/admin/admin_view_orders.dart';
import 'package:buthings/screens/admin/admin_view_products.dart';
import 'package:buthings/screens/admin/admin_view_users.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[100],
      appBar: AppBar(
        title: Text("BU Things Admin"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: PopupMenuButton<int>(
                icon: Icon(
                  Icons.person_pin,
                  size: 36,
                  color: Colors.white,
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
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: kDefaultPadding / 2,
        mainAxisSpacing: kDefaultPadding / 2,
        crossAxisCount: 2,
        children: <Widget>[
          RecentOrdersTab(),
          ProductsTab(),
          OrdersTab(),
          FeedBackTab(),
          UsersTab(),
          Container(
            child: Center(
              child: Text(
                'Bu Things',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.purpleAccent,
                    Colors.purple,
                  ]),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
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

class RecentOrdersTab extends StatelessWidget {
  const RecentOrdersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => RecentOrders())),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.purpleAccent,
                Colors.purple,
              ]),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              "Recent Orders",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        )),
      ),
    );
  }
}

class ProductsTab extends StatelessWidget {
  ProductsTab({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.purpleAccent,
              Colors.purple,
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<int>(
              future: context.read<ProductProvider>().countProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "error",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "...",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                return Text(
                  "${snapshot.data}",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                );
              }),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          OutlinedButton(
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminViewProducts())),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Products",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.purpleAccent,
              Colors.purple,
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<int>(
              future: context.read<OrderProvider>().countOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "error",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "...",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                return Text(
                  "${snapshot.data}",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                );
              }),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          OutlinedButton(
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminViewOrders())),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Orders",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class FeedBackTab extends StatelessWidget {
  const FeedBackTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.purpleAccent,
              Colors.purple,
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<int>(
              future: context.read<RatingsProvider>().countRatings(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "error",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "...",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }
                return Text(
                  "${snapshot.data}",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                );
              }),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          OutlinedButton(
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminFeedbackScreen())),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FeedBack",
                  style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class UsersTab extends StatelessWidget {
  const UsersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.purpleAccent,
              Colors.purple,
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<int>(
                future: context.read<UserProvider>().countUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('...',
                        style:
                            TextStyle(color: kPrimaryLightColor, fontSize: 64));
                  }
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 64),
                  );
                }),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white)),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminViewUsers())),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
