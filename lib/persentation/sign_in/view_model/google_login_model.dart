import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginModal {
  final GoogleSignInAuthentication googleSignInAuthentication;
  final User? user;

  GoogleLoginModal({required this.googleSignInAuthentication, required this.user});
}
