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
  final int? stock;
  final bool? isActive;

  Product({
    this.image,
    this.stock,
    this.isActive,
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
          description: json['description']! as String,
          price: json['price']! as int,
          stock: json['stock']! as int,
          isActive: json['isActive']! as bool,
          createdBy: json['createdBy'] as String,
          orders: json['orders'] as List<Order>,
          ratings: json['ratings'] as List<Rating>,
          image: json['image'] as String,
          images: json['images'] as List<MyImage>,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'isActive': isActive,
      'image': image,
      'createdBy': createdBy,
      'orders': orders!.map((order) => order.toJson()).toList(),
      'ratings': ratings!.map((rating) => rating.toJson()).toList(),
      'images': images!.map((image) => image.imagetoJson()).toList(),
    };
  }
}

class MyImage {
  String? image;

  MyImage(this.image);

  String? imagetoJson() {
    return image!;
  }
}
