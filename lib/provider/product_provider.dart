
import 'package:buthings/models/product.dart';
import 'package:buthings/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final productRepo = ProductRepository();

  Future createProduct(String uid, Product? product) {
    return productRepo.createProduct(uid,product);
  }
}