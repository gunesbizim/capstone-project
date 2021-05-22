import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

enum LoginState {
  SUCCESS,
  USER_NOT_FOUND,
  WRONG_PASWORD,
  USER_DISABLED,
  INVALID_EMAIL,
}

class LoginService extends FirebaseAuthService with ChangeNotifier {
  Future<LoginState> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return LoginState.SUCCESS;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginState.USER_NOT_FOUND;
      } else if (e.code == 'wrong-password') {
        return LoginState.WRONG_PASWORD;
      } else if (e.code == "invalid-email") {
        return LoginState.INVALID_EMAIL;
      } else
        return LoginState.USER_DISABLED;
    }
  }
}
