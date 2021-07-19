import 'package:buthings/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductRepository {
  Future<List<QueryDocumentSnapshot<Product>>> getAllProducts();
  Product? getProduct(String name);
  Future createProduct(Product? product);
  Future updateProduct(int id);
  Future deleteProduct(int id);
}

class ProductRepository extends IProductRepository {
  final productsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson(),
          );

  @override
  Future<List<QueryDocumentSnapshot<Product>>> getAllProducts() {
    return productsRef.get().then((snapshot) => snapshot.docs);
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
    return await productsRef.doc(product!.id).set(product);
  }

  @override
  Future deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future updateProduct(int id) {
    throw UnimplementedError();
  }
}
