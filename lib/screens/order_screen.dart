import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/signup_background.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/screens/address_screen.dart';
import 'package:buthings/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  final QueryDocumentSnapshot? product;

  OrdersScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignUpBackground(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: RoundedButton(
            text: 'CHECKOUT',
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddressScreen(product: product))),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
          title: Text('Orders'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: context.read<OrderProvider>().getAllOrders(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('error in orders');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.shopping_bag_outlined),
                          ),
                          title: Text('OrderNo: ${order.get('orderNo')}'),
                          subtitle: Row(
                            children: [
                              Text(
                                'Quantity: ${order.get('quantity')}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text(
                                '${order.get('product')}',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            ],
                          ),
                          trailing: Text('${order.get('price')}'),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
