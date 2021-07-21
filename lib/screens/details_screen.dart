import 'package:buthings/components/add_to_cart.dart';
import 'package:buthings/components/description.dart';
import 'package:buthings/components/product_title_with_image.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/rating.dart';
import 'package:buthings/provider/order_provider.dart';
import 'package:buthings/provider/ratings_provider.dart';
import 'package:buthings/screens/order_screen.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot? product;
  DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var numItems = 1;

  @override
  void initState() {
    super.initState();
    context.read<OrderProvider>().getOneOrder(widget.product!.get('title'));
  }

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
        height: 50,
        width: 50,
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
          _addUserRating(widget.product!, response);
        } else {
          print('Store rating of product to firebase');
          _addUserRating(widget.product!, response);
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
                        SizedBox(height: kDefaultPadding / 2),
                        Description(product: widget.product),
                        SizedBox(height: kDefaultPadding / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                buildOutlinedButton(
                                    icon: Icons.remove,
                                    press: () {
                                      if (numItems > 1) {
                                        setState(() {
                                          numItems--;
                                        });
                                      }
                                    }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding / 2),
                                  child: Text(
                                    numItems.toString().padLeft(2, "0"),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                buildOutlinedButton(
                                    icon: Icons.add,
                                    press: () {
                                      setState(() {
                                        numItems++;
                                      });
                                    }),
                              ],
                            ),
                            GestureDetector(
                              onTap: _showRatingDialog,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Image.asset("assets/icons/heart.png"),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        AddToCart(quantity: numItems, product: widget.product),
                      ],
                    ),
                  ),
                  ProductTitleWithImage(product: widget.product),
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
                      builder: (context) => OrdersScreen(
                            product: widget.product,
                          )));
            },
            icon: Icon(Icons.shopping_cart)),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }

  void _addUserRating(
      QueryDocumentSnapshot product, RatingDialogResponse response) {
    final userEmail =
        context.read<IAuthenticationService>().currentUser()!.email;
    final rating = Rating(
        id: Uuid().v1(),
        product: product.get('title'),
        user: userEmail,
        rating: response.rating,
        comment: response.comment);
    context.read<RatingsProvider>().createRating(rating);
  }

  SizedBox buildOutlinedButton({IconData? icon, Function()? press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13)))),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
