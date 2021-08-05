import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IStorageService {
  Future<TaskSnapshot> uploadImage(File file, String filename);
}

class StorageService extends IStorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  @override
  Future<TaskSnapshot> uploadImage(File file, String filename) async {
    return await _storage.ref().child('$filename').putFile(file);
  }
}
