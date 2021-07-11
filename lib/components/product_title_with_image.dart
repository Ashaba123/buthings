import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:flutter/material.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bu' Things",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product!.title!,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Price\n"),
                  TextSpan(
                    text: "UGX ${product!.price}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                ]),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Expanded(
                child: Image.asset(
                  product!.image!,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
