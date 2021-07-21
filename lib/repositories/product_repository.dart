import 'package:buthings/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductRepository {
  Stream<List<QueryDocumentSnapshot<Product>>> getAllProducts();
  Product? getProduct(String name);
  Future createProduct(Product? product);
  Future updateProduct(int id);
  Future deleteProduct(int id);
  Future<int> countProducts();
}

class ProductRepository extends IProductRepository {
  final productsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson(),
          );

  @override
  Stream<List<QueryDocumentSnapshot<Product>>> getAllProducts() {
    return productsRef
        .where('isActive', isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs)
        .asStream();
  }

  @override
  Product? getProduct(String name) {
    productsRef
        .where('title'.toLowerCase(), isEqualTo: name.toLowerCase())
        .get()
        .then((snapshot) {
      return snapshot.docs;
    });
  }

  @override
  Future createProduct(Product? product) async {
    var options = SetOptions(merge: true);
    return await productsRef.doc(product!.id).set(product, options);
  }

  @override
  Future deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future updateProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future<int> countProducts() async {
    QuerySnapshot q = await productsRef.get();
    return q.docs.length;
  }
}
