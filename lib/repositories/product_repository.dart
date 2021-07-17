import 'package:buthings/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductRepository {
  Stream<List<Product>> getAllProducts();
  Future getProduct(int id);
  Future createProduct(String userId, Product? product);
  Future updateProduct(int id);
  Future deleteProduct(int id);
}

class ProductRepository extends IProductRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }

  @override
  Future createProduct(String userId, Product? product) async {
    return await _db.collection('products').doc(userId).set(product!.toJson());
  }

  @override
  Future deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future getProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future updateProduct(int id) {
    throw UnimplementedError();
  }
}
