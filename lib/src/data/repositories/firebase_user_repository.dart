import 'package:bloc_todo_tuto/src/data/repositories/interfaces/user_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository implements UserRepositoryInterface {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<String> getUserId() async {
    return _firebaseAuth.currentUser?.uid ?? "";
  }
}
