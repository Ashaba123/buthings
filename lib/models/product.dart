import 'package:flutter/material.dart';

class Product {
  final String? image, title, description;
  final int? size, price, id;
  final Color? color;

  Product({
    this.image,
    this.title,
    this.description,
    this.size,
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
    size: 6,
    price: 15000,
    color: Colors.blue,
  ),
  Product(
    id: 2,
    image: "assets/images/books.png",
    title: "Books",
    description: dummyText,
    size: 7,
    price: 15000,
    color: Colors.deepOrange,
  ),
  Product(
    id: 3,
    image: "assets/images/african.png",
    title: "African Print",
    description: dummyText,
    size: 8,
    price: 25000,
    color: Colors.yellowAccent,
  ),
  Product(
    id: 4,
    image: "assets/images/dresses.png",
    title: "Kids Dresses",
    description: dummyText,
    size: 5,
    price: 18000,
    color: Colors.deepPurpleAccent,
  ),
  Product(
    id: 5,
    image: "assets/images/plants.png",
    title: "Potted Herbs",
    description: dummyText,
    size: 9,
    price: 10000,
    color: Colors.green,
  ),
  Product(
    id: 6,
    image: "assets/images/stars.png",
    title: "ButterFlies",
    description: dummyText,
    size: 3,
    price: 15000,
    color: Colors.blueAccent[100],
  ),
];

String? dummyText =
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit';
