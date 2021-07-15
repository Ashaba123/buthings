import 'package:buthings/models/user.dart';

class Order {
  String? id;
  String? product;
  MyUser? user;

  Order({this.id, this.product, this.user});

  Order.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          product: json['product']! as String,
          user: json['user']! as MyUser,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'product': product,
      'user': user,
    };
  }
}
