import 'package:buthings/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IOrderRepository {
  Stream<List<Order>> getAllOrders();
  Future createOrder(Order? order);
  Future updateOrder(Order order);
  Future deleteOrder(Order order);
}

class OrderRepository extends IOrderRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<List<Order>> getAllOrders() {
    return _db.collection("orders").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  @override
  Future createOrder(Order? order) async {
    return await _db
        .collection("orders")
        .doc(order!.id.toString())
        .set(order.toJson());
  }

  @override
  Future deleteOrder(Order order) {
    throw UnimplementedError();
  }

  @override
  Future updateOrder(Order order) {
    throw UnimplementedError();
  }
}
