import 'package:buthings/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  final _userRepo = UserRepository();

  Stream<DocumentSnapshot> getUser(String uid) {
    return _userRepo.getUser(uid);
  }

  Stream<List<QueryDocumentSnapshot>> getAllUsers() {
    return _userRepo.getAllUsers();
  }

  Future<int> countUsers() {
    return _userRepo.countUsers();
  }
}
