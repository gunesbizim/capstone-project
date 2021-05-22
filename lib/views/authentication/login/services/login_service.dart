import 'package:capstone_project/views/authentication/IAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
enum LoginState{
  SUCCESS,
  USER_NOT_FOUND
  
}
class LoginService extends IAuthService {
  Future<LoginState> login(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginState.USER_NOT_FOUND
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}