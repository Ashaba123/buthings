import 'package:buthings/models/product.dart';
import 'package:buthings/provider/product_provider.dart';
import 'package:buthings/screens/admin/admin_add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewProducts extends StatelessWidget {
  const AdminViewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductProvider>().getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot<Product>>>(
        stream: products,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return ListTile(
                  leading: Image.network(data.get('image')),
                  title: Text(data.get('title')),
                  subtitle: Text("UGX ${data.get('price')}"),
                  trailing: Text('Stock: ${data.get('stock')}'),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminAddProduct())),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
