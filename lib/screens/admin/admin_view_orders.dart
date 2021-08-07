import 'package:buthings/constants.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewOrders extends StatelessWidget {
  const AdminViewOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder<List<QueryDocumentSnapshot>>(
            stream: context.read<OrderProvider>().getAllOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('error in orders'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
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
    );
  }
}
