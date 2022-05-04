import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     backgroundColor: Colors.blueGrey,
    //     content: Padding(
    //       padding: EdgeInsets.all(8.0),
    //       child: Text('Successfully Register!'),
    //     ),
    //     duration: Duration(seconds: 5),
    //   ),
    // );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final AuthRepository authRepository = AuthRepository();
