import 'package:buthings/constants.dart';
import 'package:flutter/material.dart';

class Product {
  final String? image, title, description;
  final int? price, id;
  final Color? color;

  Product({
    this.image,
    this.title,
    this.description,
    this.price,
    this.id,
    this.color,
  });
}

List<Product> products = [
  Product(
    id: 1,
    image: "assets/images/butterflies.png",
    title: "ButterFlies",
    description: dummyText,
    price: 15000,
    color: Colors.pink[100],
  ),
  Product(
    id: 2,
    image: "assets/images/books.png",
    title: "Books",
    description: dummyText,
    price: 15000,
    color: kPrimaryColor,
  ),
  Product(
    id: 3,
    image: "assets/images/african.png",
    title: "African Print",
    description: dummyText,
    price: 25000,
    color: Colors.greenAccent,
  ),
  Product(
    id: 4,
    image: "assets/images/dresses.png",
    title: "Kids Dresses",
    description: dummyText,
    price: 18000,
    color: Colors.pinkAccent,
  ),
  Product(
    id: 5,
    image: "assets/images/plants.png",
    title: "Potted Herbs",
    description: dummyText,
    price: 10000,
    color: Colors.green,
  ),
  Product(
    id: 6,
    image: "assets/images/stars.png",
    title: "Luminous Stars",
    description: dummyText,
    price: 15000,
    color: Colors.orangeAccent[100],
  ),
];

String? dummyText =
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia molestiae quas '
    'vel sint commodi repudiandae consequuntur voluptatum laborumnihil, eveniet aliquid culpa.';
