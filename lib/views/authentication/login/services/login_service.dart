import 'package:capstone_project/services/FirebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginService extends AuthenticationService with ChangeNotifier {
  LoginService(FirebaseAuth firebaseAuth) : super(firebaseAuth);

  Future<Map> login(String email, String password) async {
    return signIn(email: email, password: password);
  }
}
