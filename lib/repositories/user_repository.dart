import 'package:buthings/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUserRepository {
  Stream<DocumentSnapshot> getAllUsers(String uid);
  Future createUser(MyUser user);
  Future updateUser(MyUser user);
  Future deleteUser(int id);
}

class UserRepository extends IUserRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<DocumentSnapshot> getAllUsers(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  @override
  Future createUser(MyUser? user) async {
    return await _db
        .collection('users')
        .doc(user!.id.toString())
        .set(user.toJson());
  }

  @override
  Future<void> updateUser(MyUser user) async {
    var options = SetOptions(merge: true);
    return await _db
        .collection('users')
        .doc(user.id.toString())
        .set(user.toJson(), options);
  }

  @override
  Future<void> deleteUser(int id) async {
    return await _db.collection('users').doc(id.toString()).delete();
  }
}
