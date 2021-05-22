
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}