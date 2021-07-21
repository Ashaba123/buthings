import 'package:buthings/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IOrderRepository {
  Stream<List<QueryDocumentSnapshot>> getAllOrders();
  Stream<List<QueryDocumentSnapshot>> getRecentOrders();
  Stream<List<QueryDocumentSnapshot>> getOneOrder(String id);
  Future createOrder(Order? order);
  Future updateOrder(Order order);
  Future deleteOrder(Order order);
  Future<int> countOrders();
}

class OrderRepository extends IOrderRepository {
  final _db = FirebaseFirestore.instance
      .collection('orders')
      .withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
          toFirestore: (order, _) => order.toJson());

  @override
  Stream<List<QueryDocumentSnapshot>> getAllOrders() {
    return _db.get().then((value) => value.docs).asStream();
  }

  @override
  Stream<List<QueryDocumentSnapshot>> getOneOrder(String id) {
    return _db
        .where('product', isEqualTo: id)
        .get()
        .then((snapshot) => snapshot.docs)
        .asStream();
  }

  @override
  Future createOrder(Order? order) async {
    return await _db.doc(order!.id.toString()).set(order);
  }

  @override
  Future deleteOrder(Order order) {
    throw UnimplementedError();
  }

  @override
  Future updateOrder(Order order) {
    throw UnimplementedError();
  }

  @override
  Future<int> countOrders() async {
    final QuerySnapshot q = await _db.get();
    return q.docs.length;
  }

  @override
  Stream<List<QueryDocumentSnapshot>> getRecentOrders() {
    return _db
        .where('status', isEqualTo: 'created')
        .get()
        .then((value) => value.docs)
        .asStream();
  }
}
