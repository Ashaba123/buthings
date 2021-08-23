import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/screens/admin/admin_view_orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewOrder extends StatefulWidget {
  final QueryDocumentSnapshot? order;

  AdminViewOrder({Key? key, this.order}) : super(key: key);

  @override
  _AdminViewOrderState createState() => _AdminViewOrderState();
}

class _AdminViewOrderState extends State<AdminViewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Order'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kDefaultPadding),
            Text(
              'OrderNo: ${widget.order!.get('orderNo')}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${widget.order!.get('product')}',
              style: TextStyle(fontSize: 18, color: kPrimaryColor),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              'Quantity: ${widget.order!.get('quantity')}',
              style: TextStyle(fontSize: 18, color: kPrimaryColor),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              'Delivery Address: ${widget.order!.get('address')}',
              style: TextStyle(fontSize: 18, color: kPrimaryColor),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              'Phone Number: ${widget.order!.get('phone')}',
              style: TextStyle(fontSize: 18, color: kPrimaryColor),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              'Amount to be paid: ${widget.order!.get('total')}',
              style: TextStyle(fontSize: 18, color: kPrimaryColor),
            ),
            SizedBox(height: kDefaultPadding),
            RoundedButton(
                text: 'CONFIRM ORDER',
                press: () {
                  _updateOrder(context);
                }),
          ],
        ),
      ),
    );
  }

  void _updateOrder(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false)
        .updateOrder(widget.order!.get('id'), 'confirmed');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Successfully Confirmed")));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AdminViewOrders()));
  }
}
