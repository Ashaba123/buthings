import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTitleWithImage extends StatelessWidget {
  ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;
  final List<String>? imageList = [];

  @override
  Widget build(BuildContext context) {
    //add images to list
    imageList!.addAll(product!.images!);
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
              SizedBox(width: kDefaultPadding),
              Expanded(
                  child: Container(
                height: 200,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true),
                  items: imageList!
                      .map((image) => ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              image,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ))
                      .toList(),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
