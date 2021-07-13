import 'package:buthings/models/product.dart';
import 'package:buthings/models/user.dart';

class Order {
  int? id;
  Product? product;
  User? user;

  Order(this.id, this.product, this.user);
}
