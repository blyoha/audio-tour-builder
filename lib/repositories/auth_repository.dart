import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> signInWithGoogle();

  Future<bool> isLogged();
}

class AuthRepositoryImpl implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  AuthRepositoryImpl() {
    // TODO: Add persistence
    // _auth.setPersistence(Persistence.NONE);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account with this email already exists.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("Couldn't find a user with this email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Wrong password provided.");
      } else if (e.code == 'unknown') {
        throw Exception("Please, enter email and password.");
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<bool> isLogged() async {
    return _auth.currentUser != null;
  }
}