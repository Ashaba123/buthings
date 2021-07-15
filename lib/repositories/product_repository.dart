import 'package:buthings/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductRepository {
  Stream<List<Product>> getAllProducts();
  getProduct(int id);
  createProduct(int id);
  updateProduct(int id);
  deleteProduct(int id);
}

class ProductRepository extends IProductRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }

  @override
  createProduct(int id) {
    throw UnimplementedError();
  }

  @override
  deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  getProduct(int id) {
    throw UnimplementedError();
  }

  @override
  updateProduct(int id) {
    throw UnimplementedError();
  }
}
