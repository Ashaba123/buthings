import 'package:buthings/components/login_background.dart';
import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/screens/home.dart';
import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/thanks.png",
              height: size.height * 0.5,
            ),
            Text(
              "Thank You! We shall contact you soon.",
              style: TextStyle(color: kPrimaryColor, fontFamily: "Montserrat"),
            ),
            RoundedButton(
              text: "CONTINUE",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
