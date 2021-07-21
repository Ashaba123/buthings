import 'package:buthings/provider/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Orders Made Today'),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot>>(
        stream: context.read<OrderProvider>().getRecentOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final order = snapshot.data![index];
              return ListTile(
                title: Text(order.get('orderNo')),
              );
            },
          );
        },
      ),
    );
  }
}
