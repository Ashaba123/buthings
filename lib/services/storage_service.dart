import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IStorageService {
  void uploadImage(String filename);
  void uploadTask(File file);
}

class StorageService extends IStorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  @override
  void uploadImage(String filename) {
    _storage.ref().child('uploads/$filename');
  }

  @override
  void uploadTask(File file) {
    final uploadTask = _storage.ref().putFile(file);
    uploadTask.whenComplete(() => print('complete'));
  }
}
