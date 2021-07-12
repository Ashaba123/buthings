import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Bu Things',
      // encourage your user to leave a high rating?
      message:
          'Tap a star to set your rating. Add more description here if you want.',
      // your app's logo?
      image: Image.asset("assets/images/logo.png"),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: kDefaultPadding),
          height: 50,
          width: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: widget.product!.color!),
          ),
          child: IconButton(
            onPressed: _showRatingDialog,
            icon: Icon(
              Icons.thumbs_up_down_outlined,
              color: widget.product!.color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
                  backgroundColor:
                      MaterialStateProperty.all(widget.product!.color)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Text(
                "BUY NOW",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
