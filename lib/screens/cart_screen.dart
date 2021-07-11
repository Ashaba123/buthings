import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/rounded_input_field.dart';
import 'package:buthings/components/signup_background.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      return "Invalid phone";
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
                      return "Invalid Address";
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ThankYouScreen();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Error')));
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
}