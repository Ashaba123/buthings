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
    description:
        "12 PC's of 3D Double Layer Butterflies. Wall Stickers Home Decor."
        " DIY butterflies with paper glue and Magnet for all surfaces including Metals.",
    price: 12000,
    color: Colors.orange[200],
  ),
  Product(
    id: 2,
    image: "assets/images/books.png",
    title: "Books",
    description:
        "Disney Set of 12 stories collection in Hardcover mini Storybooks Library."
        " Suitable for Bedtime stories for your child and all fun time reading.",
    price: 40000,
    color: Colors.purple[300],
  ),
  Product(
    id: 3,
    image: "assets/images/african.png",
    title: "African Print",
    description: dummyText,
    price: 45000,
    color: Colors.greenAccent,
  ),
  Product(
    id: 4,
    image: "assets/images/dresses.png",
    title: "Kids Clothes",
    description: dummyText,
    price: 35000,
    color: Colors.pinkAccent,
  ),
  Product(
    id: 5,
    image: "assets/images/plants.png",
    title: "Potted Herbs",
    description: "Potted Herbs suitable for urban places. @ 20,000/= "
        "Herbs add a blast of flavor to any meal. Everyone needs fresh ones at any time",
    price: 20000,
    color: Colors.green,
  ),
  Product(
    id: 6,
    image: "assets/images/stars.png",
    title: "Luminous Stars",
    description: "100 Pcs Home Glow in the Dark 3D Stars wall Stickers."
        " DIY decor with paper glue for Kids and baby bedrooms.",
    price: 12000,
    color: Colors.black,
  ),
  Product(
    id: 6,
    image: "assets/images/letters.png",
    title: "Alphabet Letters",
    description:
        "26 Pcs Glow in the Dark Luminous Alphabet Letters  word decor Art for Kids learning and Decor.",
    price: 12000,
    color: Colors.blue[300],
  ),
];

String? dummyText =
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia molestiae quas '
    'vel sint commodi repudiandae consequuntur voluptatum laborumnihil, eveniet aliquid culpa.';
