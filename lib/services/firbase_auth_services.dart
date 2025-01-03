import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up function
  Future<User?> signUp({required String email, required String password}) async {
    try {
      print("inside signup function");
      print(_auth);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }

  // Log In function
  Future<User?> logIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Log Out function
  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
