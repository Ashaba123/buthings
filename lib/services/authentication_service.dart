import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class IAuthenicationService {
  Future<String?> signIn({String? email, String? password});
  Future<String?> signUp({String? email, String? password});
  Stream<User?> get authStateChanges;
  User? curentUser();
}

class AuthenticationService extends IAuthenicationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({String? email, String? password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  User? curentUser() {
    return _firebaseAuth.currentUser;
  }
}
