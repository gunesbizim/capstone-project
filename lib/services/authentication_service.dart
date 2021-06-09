import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService navigationService = NavigationService.instance;
  User? get user {
    return _firebaseAuth.currentUser;
  }

  String name = "AuthenticationService:";
  static final AuthenticationService instance = AuthenticationService._init();
  AuthenticationService._init();
  //Stream<User> get authStateChanges =>_firebaseAuth.authStateChanges();

  Future<Map> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("email", email);
      prefs.setString("password", password);
      bool state = await verifyEmail();
      var userDetails = await FireStoreService.instance.getUserDetails();
      return {
        "message": 'Sign In Completed',
        "userCredential": userDetails,
        "state": state,
      };
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null, "state": false};
    }
  }

  Future<Map> tryAutoSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('email') != null &&
          prefs.getString('password') != null) {
        String? email = prefs.getString('email');
        String? password = prefs.getString('password');
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email!, password: password!);
        var userDetails = await FireStoreService.instance.getUserDetails();
        bool state = await verifyEmail();
        return {
          "message": 'Auto Sign In Completed',
          "userCredential": userDetails,
          "state": state,
        };
      } else {
        return {
          "message": 'Auto Sign In Failed',
          "userCredential": null,
          "state": null,
        };
      }
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null, "state": false};
    }
  }

  Future<Map> signUp(
      {required String email,
      required String password,
      required String fullName}) async {
    print("$name performing sign up");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("$name performing User is created with email and password");
      await FireStoreService.instance
          .setUserData(id: user!.uid, name: fullName, email: email);
      print(
          "$name userdata is set with the name of $fullName and user id of ${user!.uid}");
      var userDetails = await FireStoreService.instance.getUserDetails();

      return {"message": 'Sign In Completed', "userCredential": userDetails};
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null};
    }
  }

  Future<void> logOut() async {
    try {
      _firebaseAuth.signOut(); // signs out the #user
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      navigationService
          .navigateToPageClear(path: RouteConstants.SIGNIN, data: []);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> verifyEmail() async {
    try {
      user!.reload();
      return user!.emailVerified;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<String> returnUserEmail() async {
    try {
      var user = _firebaseAuth.currentUser;
      String? email = user!.email;
      return email!;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  void sendRecoveryEmail(String email, BuildContext context) {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      final snackBar = SnackBar(
          content: Text(
              'The recovery e mail was sent if the entered mail address is registered. Please check your email.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
