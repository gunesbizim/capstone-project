import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}
