import 'package:buthings/models/user.dart';
import 'package:buthings/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationService {
  Future<String?> signIn({String? email, String? password});
  Future<String?> signUp({String? email, String? password});
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
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? MyUser(
            id: user.uid,
            email: user.email,
            role: 'client',
            phone: 'phone',
            address: 'address')
        : null;
  }

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
      final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      MyUser? user = _userFromFirebaseUser(firebaseUser.user);
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
