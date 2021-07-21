import 'package:buthings/models/product.dart';
import 'package:buthings/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final _productRepo = ProductRepository();

  Future createProduct(Product? product) {
    return _productRepo.createProduct(product);
  }

  Product? getProduct(String name) {
    return _productRepo.getProduct(name);
  }

  Stream<List<QueryDocumentSnapshot<Product>>> getAllProducts() {
    return _productRepo.getAllProducts();
  }

  Future<int> countProducts() {
    return _productRepo.countProducts();
  }
}
