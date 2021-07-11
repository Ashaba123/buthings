import 'package:buthings/constants.dart';
import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
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
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            numItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
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
    );
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
