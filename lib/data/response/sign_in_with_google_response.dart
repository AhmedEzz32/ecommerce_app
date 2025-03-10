
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogleResponse {
  final UserCredential userCredential;
  final GoogleSignInAccount googleUser;

  SignInWithGoogleResponse({
    required this.userCredential,
    required this.googleUser,
  });
}