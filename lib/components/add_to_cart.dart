import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

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
            border: Border.all(color: product!.color!),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              color: product!.color,
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
                  backgroundColor: MaterialStateProperty.all(product!.color)),
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
