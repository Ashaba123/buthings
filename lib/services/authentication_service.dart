import 'package:buthings/models/user.dart';
import 'package:buthings/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {
  Future<User?> signIn({String? email, String? password});
  Future<String?> signUp({String? name, String? email, String? password});
  void signOut();
  Stream<User?> get authStateChanges;
  User? currentUser();
}

class AuthenticationService extends IAuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  //create User obj based on Firebase User
  MyUser? _userFromFirebaseUser(String? name, User? user) {
    return user != null
        ? MyUser(
            id: user.uid,
            name: name,
            email: user.email,
            role: 'client',
            phone: 'phone',
            address: 'address')
        : null;
  }

  Future<User?> signIn({String? email, String? password}) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<String?> signUp(
      {String? name, String? email, String? password}) async {
    try {
      final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      MyUser? user = _userFromFirebaseUser(name, firebaseUser.user);

      await UserRepository().createUser(user);

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  void signOut() {
    _firebaseAuth.signOut();
  }

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }
}
