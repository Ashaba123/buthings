import 'package:buthings/models/order.dart';
import 'package:buthings/repositories/order_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  final _orderRepo = OrderRepository();

  Future createOrder(Order? order) {
    return _orderRepo.createOrder(order);
  }

  Future updateOrder(String? id, String? status) {
    return _orderRepo.updateOrder(id, status);
  }

  Stream<List<QueryDocumentSnapshot>> getAllOrders() {
    return _orderRepo.getAllOrders();
  }

  Future<int> countOrders() {
    return _orderRepo.countOrders();
  }

  Stream<List<QueryDocumentSnapshot>> getRecentOrders() {
    return _orderRepo.getRecentOrders();
  }

  Stream<List<QueryDocumentSnapshot>> getOneOrder(String id) {
    return _orderRepo.getOneOrder(id);
  }
}
