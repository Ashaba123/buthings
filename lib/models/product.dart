import 'package:buthings/models/order.dart';
import 'package:buthings/models/rating.dart';

class Product {
  final String? id;
  final String? title, description;
  final String? image;
  final String? createdBy;
  final List<Order>? orders;
  final List<Rating>? ratings;
  final List<MyImage>? images;
  final int? price;

  Product({
    this.image,
    this.createdBy,
    this.orders,
    this.ratings,
    this.images,
    this.title,
    this.description,
    this.price,
    this.id,
  });

  Product.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          title: json['title']! as String,
          image: json['image'] as String,
          createdBy: json['createdBy'] as String,
          orders: json['orders'] as List<Order>,
          ratings: json['ratings'] as List<Rating>,
          images: json['images'] as List<MyImage>,
          description: json['description']! as String,
          price: json['price']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'createdBy': createdBy,
      'orders': orders!.map((order) => order.toJson()).toList(),
      'ratings': ratings!.map((rating) => rating.toJson()).toList(),
      'images': images!.map((image) => image.imagetoJson()).toList(),
      'description': description,
      'price': price,
    };
  }
}

class MyImage {
  String? image;

  MyImage(this.image);

  Map<String?, dynamic> imagetoJson() {
    return {'image': image};
  }
}

List<Product> products = [
  Product(
    id: "1",
    image: "assets/images/butterflies.png",
    images: [
      MyImage("assets/images/butterflies.png"),
      MyImage("assets/images/butterflies.png"),
      MyImage("assets/images/butterflies.png")
    ],
    title: "ButterFlies",
    description:
        "12 PC's of 3D Double Layer Butterflies. Wall Stickers Home Decor."
        " DIY butterflies with paper glue and Magnet for all surfaces including Metals.",
    price: 12000,
  ),
  Product(
    id: '2',
    image: "assets/images/books.png",
    images: [MyImage("assets/images/books.png")],
    title: "Books",
    description:
        "Disney Set of 12 stories collection in Hardcover mini Storybooks Library."
        " Suitable for Bedtime stories for your child and all fun time reading.",
    price: 40000,
  ),
  Product(
    id: '3',
    image: "assets/images/african.png",
    images: [MyImage("assets/images/african.png")],
    title: "African Print",
    description: dummyText,
    price: 45000,
  ),
  Product(
    id: '4',
    image: "assets/images/dresses.png",
    images: [MyImage("assets/images/dresses.png")],
    title: "Kids Clothes",
    description: dummyText,
    price: 35000,
  ),
  Product(
      id: '5',
      image: "assets/images/plants.png",
      images: [MyImage("assets/images/plants.png")],
      title: "Potted Herbs",
      description: "Potted Herbs suitable for urban places. @ 20,000/= "
          "Herbs add a blast of flavor to any meal. Everyone needs fresh ones at any time",
      price: 20000),
  Product(
      id: '6',
      image: "assets/images/stars.png",
      images: [MyImage("assets/images/stars.png")],
      title: "Luminous Stars",
      description: "100 Pcs Home Glow in the Dark 3D Stars wall Stickers."
          " DIY decor with paper glue for Kids and baby bedrooms.",
      price: 12000),
  Product(
    id: '6',
    image: "assets/images/letters.png",
    images: [MyImage("assets/images/letters.png")],
    title: "Alphabet Letters",
    description:
        "26 Pcs Glow in the Dark Luminous Alphabet Letters  word decor Art for Kids learning and Decor.",
    price: 12000,
  ),
];

String? dummyText =
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia molestiae quas '
    'vel sint commodi repudiandae consequuntur voluptatum laborumnihil, eveniet aliquid culpa.';
