import 'package:buthings/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUserRepository {
  Stream<DocumentSnapshot> getUsers(String uid);
  Stream<List<QueryDocumentSnapshot>> getAllUsers();
  Future<int> countUsers();
  Future createUser(MyUser user);
  Future updateUser(MyUser user);
  Future deleteUser(int id);
}

class UserRepository extends IUserRepository {
  final _db = FirebaseFirestore.instance
      .collection('users')
      .withConverter<MyUser>(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (myUser, _) => myUser.toJson());

  @override
  Stream<DocumentSnapshot<MyUser>> getUsers(String uid) {
    return _db.doc(uid).get().asStream();
  }

  @override
  Stream<List<QueryDocumentSnapshot>> getAllUsers() {
    return _db.get().then((value) => value.docs).asStream();
  }

  @override
  Future createUser(MyUser? user) async {
    return await _db.doc(user!.id.toString()).set(user);
  }

  @override
  Future<void> updateUser(MyUser user) async {
    var options = SetOptions(merge: true);
    return await _db.doc(user.id.toString()).set(user, options);
  }

  @override
  Future<void> deleteUser(int id) async {
    return await _db.doc(id.toString()).delete();
  }

  @override
  Future<int> countUsers() async {
    final QuerySnapshot snap = await _db.get();
    int docs = snap.docs.length;
    return docs;
  }
}
