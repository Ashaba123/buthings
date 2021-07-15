import 'package:buthings/authentication_checker.dart';
import 'package:buthings/components/already_have_account_check.dart';
import 'package:buthings/components/login_background.dart';
import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/rounded_input_field.dart';
import 'package:buthings/components/rounded_password_field.dart';
import 'package:buthings/screens/signup_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/icons/login.png",
                  height: size.height * 0.37,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Email";
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: "Your Email",
                ),
                RoundedPasswordField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Password";
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    if (formkey.currentState!.validate()) {
                      context.read<IAuthenticationService>().signIn(
                          email: emailController.text,
                          password: passwordController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AuthenticationChecker();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid Credentials, Try Again')));
                    }
                  },
                ),
                SizedBox(height: 8),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
