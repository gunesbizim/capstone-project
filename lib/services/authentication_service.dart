import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService navigationService = NavigationService.instance;
  User? get user {
    return _firebaseAuth.currentUser;
  }

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
    print('here');
    try {
      print(prefs.getString('email'));
      print(prefs.getString('password'));
      if (prefs.getString('email') != null &&
          prefs.getString('password') != null) {
        print('here2');
        String? email = prefs.getString('email');
        String? password = prefs.getString('password');
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email!, password: password!);
        var userDetails = await FireStoreService.instance.getUserDetails();
        bool state = await verifyEmail();
        print(state);
        return {
          "message": 'Auto Sign In Completed',
          "userCredential": userDetails,
          "state": state,
        };
      } else {
        print('here3');
        return {
          "message": 'Auto Sign In Failed',
          "userCredential": null,
          "state": null,
        };
      }
    } on FirebaseAuthException catch (e) {
      print('here4');
      return {"message": e.message, "userCredential": null, "state": false};
    }
  }

  Future<Map> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      print(user!.email);
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
}
