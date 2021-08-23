import 'dart:math';

import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/rounded_input_field.dart';
import 'package:buthings/components/signup_background.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/order.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/screens/thank_you_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final QueryDocumentSnapshot? product;
  final int? quantity;
  const AddressScreen(
      {Key? key, required this.quantity, @required this.product})
      : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SignUpBackground(
          child: BackButton(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SignUpBackground(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "MY CART",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Image.asset(
                  "assets/images/checkout.png",
                  height: size.height * 0.35,
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                RoundedInputField(
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter phone number";
                    }
                    return null;
                  },
                  controller: phoneController,
                  hintText: "Your Phone Number",
                ),
                RoundedInputField(
                  maxlines: 3,
                  icon: Icons.pin_drop,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Address";
                    }
                    return null;
                  },
                  controller: addressController,
                  hintText: "Your Address. Where Can we find you",
                ),
                RoundedButton(
                  text: "CHECKOUT",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      //create order
                      _addOrder(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter all credentials')));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addOrder(BuildContext context) {
    final user = context.read<IAuthenticationService>().currentUser()!.email;
    String orderNo = 'B${Random().nextInt(1000)}';
    print('orderNo: $orderNo');

    int qty = (widget.quantity!);
    int pr = (widget.product!.get('price'));
    final priceTotal = (qty * pr);

    final order = Order(
        id: Uuid().v4(),
        orderNo: orderNo,
        product: widget.product!.get('title'),
        userEmail: user,
        quantity: widget.quantity,
        price: widget.product!.get('price'),
        total: priceTotal,
        address: addressController.text,
        phone: phoneController.text,
        status: 'created');
    context.read<OrderProvider>().createOrder(order);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ThankYouScreen()));
  }
}
