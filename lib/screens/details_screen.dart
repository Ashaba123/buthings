import 'package:buthings/components/add_to_cart.dart';
import 'package:buthings/components/cart_counter.dart';
import 'package:buthings/components/color_dot.dart';
import 'package:buthings/components/description.dart';
import 'package:buthings/components/product_title_with_image.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/screens/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class DetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot? product;
  DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Color"),
                        Row(children: [
                          ColorDot(
                            color: Colors.purpleAccent,
                            isSelected: true,
                          ),
                          ColorDot(
                            color: Colors.teal,
                          ),
                          ColorDot(
                            color: Colors.orange,
                          ),
                        ]),
                        SizedBox(height: kDefaultPadding / 2),
                        Description(product: product),
                        SizedBox(height: kDefaultPadding / 2),
                        CounterWithFavButton(),
                        SizedBox(height: kDefaultPadding / 2),
                        AddToCart(product: product),
                      ],
                    ),
                  ),
                  ProductTitleWithImage(product: product),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purpleAccent,
      elevation: 0,
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            product: product,
                          )));
            },
            icon: Icon(Icons.shopping_cart)),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}

class CounterWithFavButton extends StatefulWidget {
  // actual store listing review & rating
  @override
  _CounterWithFavButtonState createState() => _CounterWithFavButtonState();
}

class _CounterWithFavButtonState extends State<CounterWithFavButton> {
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Bu Things',
      // encourage your user to leave a high rating?
      message:
          'Tap a star to set your rating. Add more description here if you want.',
      // your app's logo?
      image: Image.asset(
        "assets/images/logo.png",
        height: 100,
        width: 100,
      ),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
          print('Store rating of product to firebase');
        } else {
          print('Store rating of product to firebase');
        }
      },
    );

    //show dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        GestureDetector(
          onTap: _showRatingDialog,
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 32,
            width: 32,
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Image.asset("assets/icons/heart.png"),
          ),
        )
      ],
    );
  }
}
