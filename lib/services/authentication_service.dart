import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {
  Future<String?> signIn({String? email, String? password});
  Future<String?> signUp({String? email, String? password});
  Stream<User?> get authStateChanges;
  User? currentUser();
}

class AuthenticationService extends IAuthenticationService {
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

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }
}
