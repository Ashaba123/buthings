import 'package:buthings/components/add_to_cart.dart';
import 'package:buthings/components/cart_counter.dart';
import 'package:buthings/components/color_dot.dart';
import 'package:buthings/components/description.dart';
import 'package:buthings/components/product_title_with_image.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Product? product;
  const DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: product!.color,
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
                    //height: 500,
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
                            color: product!.color,
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
      backgroundColor: product!.color,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart)),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}

class CounterWithFavButton extends StatelessWidget {
  const CounterWithFavButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8.0),
          height: 32,
          width: 32,
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Image.asset("assets/icons/heart.png"),
        )
      ],
    );
  }
}
