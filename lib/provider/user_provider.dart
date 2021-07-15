import 'package:buthings/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  final userRepo = UserRepository();

  Stream<DocumentSnapshot> getAllUsers(String uid) {
    return userRepo.getAllUsers(uid);
  }
}
