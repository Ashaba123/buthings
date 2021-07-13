import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDatabaseService {}

class DatabaseService extends IDatabaseService {
  final FirebaseFirestore _firebaseFirestore;
  DatabaseService(this._firebaseFirestore);
}
