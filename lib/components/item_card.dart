import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Product? product;
  final Function()? press;
  const ItemCard({
    Key? key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 180,
              width: 160,
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: product!.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(product!.image!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              product!.title!,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\UGX10,000",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
