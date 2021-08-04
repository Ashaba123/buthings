import 'package:buthings/components/already_have_account_check.dart';
import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/rounded_input_field.dart';
import 'package:buthings/components/rounded_password_field.dart';
import 'package:buthings/components/signup_background.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/screens/home.dart';
import 'package:buthings/screens/login_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignUpBackground(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/icons/signup.png",
                  height: size.height * 0.35,
                ),
                RoundedInputField(
                  icon: Icons.person,
                  textInputAction: TextInputAction.next,
                  hintText: "Your Username",
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Username";
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                RoundedInputField(
                  icon: Icons.email,
                  textInputAction: TextInputAction.next,
                  hintText: "Your Email",
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Email";
                    }
                    if (emailValid(val)) {
                      return "Enter a valid  Email";
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Password";
                    }
                    return null;
                  },
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      context.read<IAuthenticationService>().signUp(
                          email: emailController.text,
                          password: passwordController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error! Try Again')));
                    }
                  },
                ),
                SizedBox(height: 8),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    //google sign in
                  },
                  child: Card(
                    child: Ink(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/google.png",
                              height: size.height * 0.03,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool emailValid(String email) {
    return RegExp(
            r"/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/")
        .hasMatch(email);
  }
}
