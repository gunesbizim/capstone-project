import 'package:capstone_project/core/constants/values/route_constants.dart';
import 'package:capstone_project/services/navigation/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService navigationService = NavigationService.instance;
  User? get  user{
    return _firebaseAuth.currentUser;
  }

  static final AuthenticationService instance = AuthenticationService._init();
  AuthenticationService._init();
  //Stream<User> get authStateChanges =>_firebaseAuth.authStateChanges();

  Future<Map> signIn({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      bool state = await verifyEmail();
      return {
        "message": 'Sign In Completed',
        "userCredential": userCredential,
        "state": state,
      };
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null, "state": false};
    }
  }

  Future<Map> signUp({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(userCredential);
      return {"message": 'Sign In Completed', "userCredential": userCredential};
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null};
    }
  }

  Future<void> logOut() async {
    try {
      _firebaseAuth.signOut(); // signs out the #user
      navigationService.navigateToPageClear(path: RouteConstants.SIGNIN,data:[]);
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
